# Create Categories
200.times do
  Category.create(name: Faker::Commerce.department)
end

# Create Products
30000.times do |i|
  Product.create(
    name: "#{Faker::Commerce.product_name} #{i}",
    price: Faker::Commerce.price(range: 10.0..100.0),
    description: Faker::Lorem.sentence,
    category_id: Category.pluck(:id).sample
  )
end


# Create Users
500.times do |i|
  User.create(name: Faker::Name.name, email: Faker::Internet.email)
end

# Create Orders
5000.times do
  Order.create(
    quantity: rand(1..10),
    user_id: User.pluck(:id).sample,
    product_id: Product.pluck(:id).sample
  )
end
