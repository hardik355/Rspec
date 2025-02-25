# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  price       :decimal(, )
#  description :text
#  handle      :string
#  status      :integer
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#

class Product < ApplicationRecord
  belongs_to :category
  has_many :orders, dependent: :restrict_with_error

  # Validation
  validates :title, presence: true

  before_destroy :check_order_exist  # Call before deleting

  private

  def check_order_exist
    if orders.any?
      errors.add(:base, "Cannot delete product with orders")
      throw(:abort)  # 🔹 Stop deletion
    end 
  end
end
