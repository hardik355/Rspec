# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it "User create with valid data" do
    user = User.create(name: "Hardik", email: "hardik355@gmail.com")
    expect(user).to be_valid
  end

  describe "Validation" do 
    before do 
      @user = User.create!(name: "Hardik", email: "hardik355@gmail.com")
      @category = Category.create(name: "Mobile")
      @product = Product.create!(name: "Iphone 11", category_id: @category.id)
      @order = Order.create(quantity: 10, user_id: @user.id, product_id: @product.id)
    end 

    it "Invalid user with same email" do
      user = User.new(name: "Hardik", email: "hardik355@gmail.com")
      user.valid?
      expect(user.errors[:email]).to include("has already been taken") 
    end

    it "Invalid user with same email" do
      user = User.new(name: "Hardik", email: "hardik355@gmail.com")
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken") 
    end

    # dependent Destroy
    it "Dependent destroy failed" do
      @user = User.create!(name: "sam", email: "sam355@gmail.com")
      @product = Product.create!(name: "Iphone 11", category_id: @category.id)
      @order = Order.create!(quantity: 10, user_id: @user.id, product_id: @product.id)
      expect {@user.destroy}.to change {Order.count}.by(-1)
    end 
  end 
end
