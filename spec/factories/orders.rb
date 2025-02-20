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
    association :user
    association :product
  end
end
