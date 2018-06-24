class Account::Update < ApplicationService
  def initialize(params, account_id)
    @account_id     = account_id
    @account_status = params[:account_status]
    @birthdate      = params[:birthdate]
    @cpf            = params[:cpf]
    @cnpj           = params[:cnpj]
    @full_name      = params[:full_name]
    @name           = params[:name]
    @trade_name     = params[:trade_name]
    @social_name    = params[:social_name]
  end

  def call
    update_account
  end

  private

  def update_account
    ActiveRecord::Base.transaction do
      account = Account.find @account_id
      account.tap do |a|
        a.account_status = @account_status if @account_status
        a.name = @name if @name
        a.person.tap do |p|
          p.birthdate   = @birthdate if @birthdate
          p.cnpj        = @cnpj if @cnpj
          p.cpf         = @cpf if @cpf
          p.full_name   = @full_name if @full_name
          p.social_name = @social_name if @social_name
          p.trade_name  = @trade_name if @trade_name
          p.save
        end
        a.save
      end

      account.reload
    end
  end
end
