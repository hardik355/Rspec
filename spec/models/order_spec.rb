# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  browser_ip    :string
#  cancel_reason :string
#  cancelled_at  :datetime
#  currency      :string
#  quantity      :integer
#  user_id       :integer          not null
#  product_id    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_orders_on_product_id  (product_id)
#  index_orders_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  context "Valide record" do
    before do 
      @user = User.create!(first_name: "Hardik", email: "hardik355@gmail.com", password_digest: "asjkdjkasnk")
      @category = Category.create(title: "Mobile")
      @product = Product.create!(title: "Iphone 11", category_id: @category.id)
      @order = Order.create(quantity: 10, user_id: @user.id, product_id: @product.id)
    end

    it "Order create" do
      order = Order.create(quantity: 10, user_id: @user.id, product_id: @product.id)
      expect(order).to be_valid
    end
  end 

  context "validation" do
    before do 
      @user = User.create!(first_name: "Hardik", email: "hardik355@gmail.com", password_digest: "455asaas")
      @category = Category.create(title: "Mobile")
      @product = Product.create!(title: "Iphone 11", category_id: @category.id)
      @order = Order.create(quantity: 10, user_id: @user.id, product_id: @product.id)
    end

    #user must be require
    it "User must be require" do 
      order = Order.new(quantity: 10, product_id: @product.id)
      order.valid?
      expect(order.errors[:user]).to include("must exist", "can't be blank")
    end
    
    it "User must be require" do 
      order = Order.new(quantity: 10, product_id: @product.id)
      expect(order).to_not be_valid
      expect(order.errors[:user]).to include("must exist", "can't be blank")
    end

    it "Quantity must exist" do
      order = Order.new(user_id: @user.id, product_id: @product.id)
      order.valid?
      expect(order.errors[:quantity]).to include("can't be blank")
    end
    
    it "Quantity must exist" do
      order = Order.new(user_id: @user.id, product_id: @product.id)
      expect(order).to_not be_valid
      expect(order.errors[:quantity]).to include("can't be blank")
    end

    it "Product must exist" do
      order = Order.new(quantity: 10, user_id: @user.id)
      order.valid?
      expect(order.errors[:product]).to include("must exist")
    end

    it "Product must exist" do
      order = Order.new(quantity: 10, user_id: @user.id)
      expect(order).to_not be_valid
      expect(order.errors[:product]).to include("must exist")
    end


    it "Quantity and user must be exist" do
      order = Order.new(product_id: @product.id)
      order.valid?
      expect(order.errors[:user]).to include("must exist", "can't be blank")
      expect(order.errors[:quantity]).to include("can't be blank")
    end

    it "User and Product must be exist" do
      order = Order.new(quantity: 100)
      order.valid?
      expect(order.errors[:user]).to include("must exist", "can't be blank")
      expect(order.errors[:product]).to include("must exist")
    end


    it "User and Product And quantity must be exist" do
      order = Order.new()
      order.valid?
      expect(order.errors[:user]).to include("must exist", "can't be blank")
      expect(order.errors[:product]).to include("must exist")
      expect(order.errors[:quantity]).to include("can't be blank")
    end

    # dependent Destroy
    it "Dependent destroy failed" do
      @user = User.create!(first_name: "sam", email: "sam355@gmail.com", password_digest: "dajkshkjas654656")
      @product = Product.create!(title: "Iphone 11", category_id: @category.id)
      @order = Order.create!(quantity: 10, user_id: @user.id, product_id: @product.id)
      expect {@order.destroy}.to change {Order.count}.by(-1)
    end
  end
end
