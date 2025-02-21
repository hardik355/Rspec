# == Schema Information
#
# Table User: users
#
#  id         :integer          not null, primary key
#  first_name :string
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
    user = User.create(first_name: "Hardik", email: "hardik355@gmail.com", password_digest: "asjkdjkasnk")
    expect(user).to be_valid
  end

  describe "Validation" do 
    before do 
      @user = User.create!(first_name: "Hardik", email: "hardik355@gmail.com", password_digest: "asjkdjkasnk")
      @category = Category.create(title: "Mobile")
      @product = Product.create!(title: "Iphone 11", category_id: @category.id)
      @order = Order.create(quantity: 10, user_id: @user.id, product_id: @product.id)
    end 

    it "Invalid user with same email" do
      user = User.new(first_name: "Hardik", email: "hardik355@gmail.com", password_digest: "asjkdjkasnk")
      user.valid?
      expect(user.errors[:email]).to include("has already been taken") 
    end

    it "Invalid user with same email" do
      user = User.new(first_name: "Hardik", email: "hardik355@gmail.com", password_digest: "asjkdjkasnk")
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken") 
    end

    # dependent Destroy
    it "Dependent destroy failed" do
      @user = User.create!(first_name: "sam", email: "sam355@gmail.com", password_digest: "asjkdjkasnk")
      @product = Product.create!(title: "Iphone 11", category_id: @category.id)
      @order = Order.create!(quantity: 10, user_id: @user.id, product_id: @product.id)
      expect {@user.destroy}.to change {Order.count}.by(-1)
    end 
  end

  # Using FactoryBot  
  it "User is valid" do 
    user = create(:user)
    expect(user).to be_valid
  end

  it "Duplicate record is invalid" do
    user = create(:user, email: "test@yopmail.com")
    user1 = build(:user, email: "test@yopmail.com")
    expect(user1).to_not be_valid
    expect(user1.errors[:email]).to include("has already been taken")
  end
end
