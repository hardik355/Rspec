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

FactoryBot.define do
  factory :category do
    name { Faker::Commerce.department }
  end
end
