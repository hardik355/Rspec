# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :decimal(, )
#  description :text
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  before do 
    @category = Category.create(name: "Car")
  end

  it "Create a valid record" do
    product = Product.new(
      name: "BMW GT",
      category_id: @category.id
    )
    expect(product).to be_valid
  end
  
  # Case 1 invalid
  it "It is invalid" do
    product = Product.new(
      name: "BMW GT"
    )
    product.valid?
    expect(product.errors["category"]).to include("must exist")
  end

  # Case 2 different syntex
  it "It is invalid" do
    product = Product.new(
      name: "BMW GT"
    )
    expect(product).to_not be_valid
    expect(product.errors["category"]).to include("must exist")
  end

  # Destro Test Case
  # 1.Destroy
  before do
    @product = Product.create(name: "Iphone 11", category_id: @category.id)
    @user = User.create(name: "Hardik Patel", email: "hardik355@yopmail.com")
    @order = Order.create(quantity: 10, user_id: @user.id, product_id: @product.id) 
  end

  it "If product have any order then product delete failed" do
    expect{ @product.destroy }.to_not change { Product.count}
    expect(@product.errors[:base]).to include("Cannot delete record because dependent orders exist")
  end

end
