FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 10..1000) }
    description { Faker::Lorem.sentence }
    category
  end
end
