FactoryBot.define do
  factory :account do
    trait :active do
      account_status :active
    end

    trait :blocked do
      account_status :blocked
    end

    trait :canceled do
      account_status :canceled
    end

    trait :matrix do
      account_type :matrix
    end

    trait :branch do
      account_type :branch
    end

    name 'Account Name'
    balance 0.0
  end
end
