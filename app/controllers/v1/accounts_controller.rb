class V1::AccountsController < ApplicationController
  before_action :set_account, only: %i[show update destroy]

  def show
    @account = Account.find params[:id]
    render json: @account, status: :ok
  end

  def create
    @account = Account::Create.call(account_params)
    render json: @account, status: :created
  end

  def update
    @account = Account::Update.call(account_params, @account.id)
    render json: @account, status: :ok
  end

  def destroy
    @account.destroy
    render status: :no_content
  end

  private

  def set_account
    @account = Account.find params[:id]
  end

  def account_params
    params.require(:account)
          .permit(:parent_id, :name, :person_type, :birthdate, :cnpj,
                  :cpf, :full_name, :social_name, :trade_name, :account_status)
  end
end
