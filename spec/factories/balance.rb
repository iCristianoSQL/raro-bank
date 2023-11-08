FactoryBot.define do
  factory :balance do
    withdrawn { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    balance_deposited { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    current_balance { Faker::Number.decimal(l_digits: 2, r_digits: 2).to_f.abs }
    association :user, factory: :user
  end
end
