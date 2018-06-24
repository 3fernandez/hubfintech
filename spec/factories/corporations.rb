FactoryBot.define do
  factory :corporation, parent: :person, class: 'Corporation' do
    cnpj '12345678901234'
    social_name 'Test Company'
    trade_name 'Test Company 2'
  end
end
