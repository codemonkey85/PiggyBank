module PiggyBank
  class App < Sinatra::Base
    get "/accounts" do
      haml :"account/index",
          layout: :layout #,
      #locals: { accounts: DB[:account].all.to_s }
    end
  end
end
