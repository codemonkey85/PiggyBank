module PiggyBank
  class App < Sinatra::Base
    def general_form
      haml_layout :"tax/data/general/index"
    end

    def income_form
      haml_layout :"tax/data/income/index"
    end

    def deduct_form
      haml_layout :"tax/data/deduct/index"
    end

    get "/tax/data" do
      haml_layout :"tax/data/index"
    end

    get "/tax/data/general" do
      @general = PiggyBank::Tax::Data::General.new
      general_form
    end

    post "/tax/data/general" do
      @general = PiggyBank::Tax::Data::General.new
      @general.update params

      if params.has_key? "add_dep"
        @general.add_dependent
        general_form
      elsif params.has_key? "rm_dep"
        @general.rm_dependent params["rm_dep"]
        general_form
      else
        @general.save
        flash[:success] = "General tax data saved."
        redirect to "/tax/data"
      end
    end

    get "/tax/data/income" do
      @income = PiggyBank::Tax::Data::Income.new
      haml_layout :"tax/data/income/index"
    end

    post "/tax/data/income" do
      @income = PiggyBank::Tax::Data::Income.new
      @income.update params

      if params.has_key? "add_w2"
        @income.add_w2
        income_form
      elsif params.has_key? "rm_w2"
        @income.rm_w2 params["rm_w2"]
        income_form
      elsif params.has_key? "add_rental"
        @income.add_rental
        income_form
      elsif params.has_key? "rm_rental"
        @income.rm_rental params["rm_rental"]
        income_form
      else
        @income.save
        flash[:success] = "Income data saved."
        redirect to "/tax/data"
      end
    end

    get "/tax/data/deduct" do
      @deduct = PiggyBank::Tax::Data::Deduct.new
      deduct_form
    end

    post "/tax/data/deduct" do
      @deduct = PiggyBank::Tax::Data::Deduct.new
      @deduct.update params

      if params.has_key? "add_1098"
        @deduct.add_1098
        deduct_form
      elsif params.has_key? "rm_1098"
        @deduct.rm_1098 params["rm_1098"]
        deduct_form
      else
        @deduct.save
        flash[:success] = "Deduction data saved."
        redirect to "/tax/data"
      end
    end

    get "/tax/data/tax" do
      haml_layout :"tax/data/tax/index"
    end

    post "/tax/data/tax" do
      haml_layout :"tax/data/tax/index"
    end

    get "/tax/forms" do
      haml_layout :"tax/form/index"
    end

    forms = {
      "us" => {
        "form_1040" => PiggyBank::Tax::Form::Writer::US::Form1040,
        "form_8283" => PiggyBank::Tax::Form::Writer::US::Form8283,
        "form_8889" => PiggyBank::Tax::Form::Writer::US::Form8889,
        "sched_1" => PiggyBank::Tax::Form::Writer::US::Schedule1,
        "sched_3" => PiggyBank::Tax::Form::Writer::US::Schedule3,
        "sched_a" => PiggyBank::Tax::Form::Writer::US::ScheduleA,
        "sched_e" => PiggyBank::Tax::Form::Writer::US::ScheduleE,
      },
    }

    forms.each_key do |group|
      forms[group].each_pair do |form, writer|
        get "/tax/form/#{group}/#{form}" do
          pdf = writer.new.write_form
          halt 200, { "Content-Type" => "application/pdf" }, pdf
        end
      end
    end
  end
end
