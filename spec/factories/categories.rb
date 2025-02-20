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
    title { Faker::Commerce.unique.department }
    handle { Faker::Internet.unique.slug }
    body_html { Faker::Lorem.paragraph }
    published_at { Faker::Time.between(from: 2.days.ago, to: Time.now) }
    collection_type { %w[manual automated].sample }
    rules { Faker::Lorem.sentence }
  end
end
