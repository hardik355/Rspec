# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :decimal(, )
#  description :text
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
  has_many :orders, dependent: :destroy

  # Validation
  validates :name, presence: true

end
