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


  it "Categoty name is uniq" do
    catogery = Category.create!(
      name: "Wall-Paper"
    )

    catogery = Category.new(
      name: "Wall-Paper"
    )
    catogery.valid?
    expect(catogery.errors[:name]).to include('has already been taken')
  end
end
