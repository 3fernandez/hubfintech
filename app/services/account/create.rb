class Account::Create < ApplicationService
  def initialize(params)
    @birthdate   = params[:birthdate]
    @cpf         = params[:cpf]
    @cnpj        = params[:cnpj]
    @full_name   = params[:full_name]
    @name        = params[:name]
    @parent_id   = params[:parent_id]
    @person_type = params[:person_type]
    @trade_name  = params[:trade_name]
    @social_name = params[:social_name]
  end

  def call
    create_account
  end

  private

  def create_account
    ActiveRecord::Base.transaction do
      account = Account.new.tap do |a|
        a.account_type = account_type
        a.account_status = :active
        a.name = @name
        a.parent_id = parent_id
        a.save!
      end

      if corporation?
        Corporation.create(cnpj: @cnpj, social_name: @social_name,
                           trade_name: @trade_name, account_id: account.id)
      else
        Individual.create(cpf: @cpf, full_name: @full_name,
                          birthdate: @birthdate, account_id: account.id)
      end

      account.reload
    end
  end

  def account_type
    parent? ? :branch : :matrix
  end

  def parent_id
    parent? ? @parent_id : nil
  end

  def corporation?
    if person? && @person_type.casecmp('corporation').zero?
      true
    else
      false
    end
  end

  def parent?
    @parent_id.present? ? true : false
  end

  def person?
    @person_type.present? ? true : false
  end
end
