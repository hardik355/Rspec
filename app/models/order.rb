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

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # Validation
  validates :quantity, :user, presence: true
end
