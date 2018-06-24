FactoryBot.define do
  factory :individual, parent: :person, class: 'Individual' do
    cpf '12345678901'
    full_name 'Joe Doe'
    birthdate '20/08/1900'
  end
end
