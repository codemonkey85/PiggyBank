module PiggyBank
  class App < Sinatra::Base

    # def tx_find(id)
    #   PiggyBank::Tx.find(tx_id: id)
    # end

    def tx_index
      @txs = PiggyBank::Tx.all
      haml_layout :"tx/index"
    end

    # def tx_new
    #   @method = "POST"
    #   @action = "/tx"
    #   @header = "New Tx"
    #   haml_layout :"tx/edit"
    # end

    # def tx_create(params)
    #   @tx = PiggyBank::Tx.create(
    #     quote_date: params["quote_date"],
    #     commodity_id: params["commodity_id"],
    #     currency_id: params["currency_id"],
    #     value: params["value"],
    #   )

    #   flash[:success] = "Tx created."
    #   redirect to "/txs"
    # end

    # def tx_view
    #   haml_layout :"tx/view"
    # end

    # def tx_edit
    #   @action = "/tx/#{@tx.tx_id}"
    #   @method = "PUT"
    #   @header = "Edit Tx"

    #   haml_layout :"tx/edit"
    # end

    # def tx_update
    #   haml :"tx/view"
    # end

    # def tx_diff(orig_tx, new_tx)
    #   @tx = orig_tx
    #   @new_tx = new_tx
    #   haml :"tx/diff"
    # end

    # def tx_confirm
    #   @action = "/tx/#{@tx.tx_id}"
    #   @method = "DELETE"
    #   haml_layout :"tx/delete"
    # end

    # def tx_delete
    #   flash[:success] = "Tx deleted."
    #   @tx.destroy
    #   redirect to "/txs"
    # end

    # # ROUTES

    get "/txs" do
      tx_index
    end

    # get "/tx" do
    #   @tx = PiggyBank::Tx.new
    #   tx_new
    # end

    # post "/tx" do
    #   if params["_token"] != PiggyBank::App.token
    #     @tx = PiggyBank::Tx.new
    #     @tx.set_fields params, PiggyBank::Tx.update_fields
    #     flash.now[:danger] = "Failed to create, please try again"
    #     halt 403, tx_new
    #   else
    #     tx_create params
    #   end
    # end

    # get "/tx/:id" do |id|
    #   @tx = tx_find id
    #   if params.has_key? "edit"
    #     tx_edit
    #   elsif params.has_key? "delete"
    #     tx_confirm
    #   else
    #     tx_view
    #   end
    # end

    # put "/tx/:id" do |id|
    #   @tx = tx_find id
    #   if params["_token"] != PiggyBank::App.token
    #     @tx.set_fields params, PiggyBank::Tx.update_fields
    #     flash.now[:danger] = "Failed to save changes, please try again"
    #     halt 403, tx_edit
    #   elsif params["version"] != @tx.version
    #     orig = @tx.clone
    #     @tx.set_fields params, PiggyBank::Tx.update_fields
    #     flash.now[:danger] = "Someone else updated this tx, please confirm changes"
    #     halt 409, tx_diff(orig, @tx)
    #   else
    #     @tx.update_fields params, PiggyBank::Tx.update_fields
    #     tx_update
    #   end
    # end

    # delete "/tx/:id" do |id|
    #   @tx = tx_find id
    #   if params["_token"] != PiggyBank::App.token
    #     flash.now[:danger] = "Failed to delete, please try again"
    #     halt 403, tx_confirm
    #   elsif params["version"] != @tx.version
    #     flash.now[:danger] = "Someone else updated this tx, please re-confirm delete"
    #     halt 409, tx_confirm
    #   else
    #     tx_delete
    #   end
    # end

  end
end
