FactoryBot.define do
  factory :user do
    first_name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
  end
end
