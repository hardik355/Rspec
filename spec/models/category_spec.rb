require 'rails_helper'

RSpec.describe Category, type: :model do
  it "Create a catogery with valid data" do
    catogery = Category.new(
      name: "Watch"
    )
    expect(catogery).to be_valid
  end

  it "Categoty is invalid without name" do
    catogery = Category.new(name: nil)
    catogery.valid?
    expect(catogery.errors[:name]).to include("can't be blank")
  end

  # Uniq Case
  # Case 1
  it "Categoty name is uniq" do
    catogery = Category.create!(name: "Wall-Paper")
    catogery = Category.new(name: "Wall-Paper")
    catogery.valid?
    expect(catogery.errors[:name]).to include('has already been taken')
  end

  # Case 2
  it "Categoty name is uniq" do
    catogery = Category.create!(name: "Car")
    catogery = Category.new( name: "Car")
    expect(catogery).to_not be_valid
    expect(catogery.errors[:name]).to include('has already been taken')
  end

  # Subject Case 
  subject { catogery = Category.new(
      name: "Watch"
    )
  }

  it "it is valid record" do 
    expect(subject).to be_valid
  end
  
  it "It is in valid because of nil value" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  # Before and After Case
  before do 
    @category = Category.create(name: "Book")
  end 

  it "is valid" do 
    expect(@category).to be_valid
  end 

  it "is invalid" do
    @category.name = nil
    expect(@category).to_not be_valid
  end
end
