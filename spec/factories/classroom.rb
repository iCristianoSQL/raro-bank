FactoryBot.define do
  factory :classroom do
    name { Faker::Name.name }
    user { association :user } 
  end
end
