require 'rails_helper'

RSpec.describe Individual, type: :model do
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:birthdate) }
end
