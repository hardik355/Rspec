FactoryBot.define do
  factory :user do
    first_name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password_digest {Faker::Internet.password(min_length: 10, max_length: 20)}
  end
end
