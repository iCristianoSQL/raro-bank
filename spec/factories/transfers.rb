FactoryBot.define do
  factory :transfer do
    association :sender, factory: :user
    association :receiver, factory: :user
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    token { Faker::Alphanumeric.alpha(number: 10) }
    status { 1 }
  end
end
