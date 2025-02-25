# == Schema Information
#
# Table name: categories
#
#  id              :integer          not null, primary key
#  title           :string
#  handle          :string
#  body_html       :string
#  published_at    :datetime
#  collection_type :string
#  rules           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  it "Create a catogery with valid data" do
    catogery = Category.new(
      title: "Watch"
    )
    expect(catogery).to be_valid
  end

  it "Categoty is invalid without title" do
    catogery = Category.new(title: nil)
    catogery.valid?
    expect(catogery.errors[:title]).to include("can't be blank")
  end

  # # Uniq Case
  # # Case 1
  it "Categoty title is uniq" do
    catogery = Category.create!(title: "Wall-Paper")
    catogery = Category.new(title: "Wall-Paper")
    catogery.valid?
    expect(catogery.errors[:title]).to include('has already been taken')
  end

  # # Case 2
  it "Categoty title is uniq" do
    catogery = Category.create!(title: "Car")
    catogery = Category.new( title: "Car")
    expect(catogery).to_not be_valid
    expect(catogery.errors[:title]).to include('has already been taken')
  end

  # # Subject Case 
  subject { catogery = Category.new(
      title: "Watch"
    )
  }

  it "it is valid record" do 
    expect(subject).to be_valid
  end
  
  it "It is in valid because of nil value" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  # # Before and After Case
  before do 
    @category = Category.create(title: "Book")
  end 

  it "is valid" do 
    expect(@category).to be_valid
  end 

  it "is invalid" do
    @category.title = nil
    expect(@category).to_not be_valid
  end

  # # DELETE TEST CASE 
  before do
    @category = Category.create(title: "car")
    product1 = Product.create(title: "BMW GT", category_id: @category.id)
    product2 = Product.create(title: "BMW X1", category_id: @category.id)
  end

  # # Sucuess
  it "Category Delete" do
    expect { @category.destroy }.to change { Category.count }.by(-1)
    expect( Product.where(category_id: @category.id).count ).to eq(0)
  end
end
