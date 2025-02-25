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

FactoryBot.define do
  factory :order do
    quantity { 10 }
    currency { Faker::Currency.code }  # Generates a valid currency code (e.g., USD, EUR)
    browser_ip { Faker::Internet.ip_v4_address }  # Generates a random IPv4 address
    cancel_reason { nil }  # Default as nil unless needed
    cancelled_at { nil }  # Default as nil unless canceled
    association :user  # Ensures a user is created
    association :product  # Ensures a product is created

    # Define a trait for canceled orders if needed
    trait :canceled do
      cancel_reason { "Customer Request" }
      cancelled_at { Time.current }
    end
  end
end

