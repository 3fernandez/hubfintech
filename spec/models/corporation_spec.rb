require 'rails_helper'

RSpec.describe Corporation, type: :model do
  it { should validate_presence_of(:cnpj) }
  it { should validate_presence_of(:social_name) }
  it { should validate_presence_of(:trade_name) }
end
