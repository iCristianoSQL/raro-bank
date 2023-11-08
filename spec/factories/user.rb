FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end
  trait :administrator do
    after(:create) do |user|
      create(:administrator, user: user)
    end
  end
end
