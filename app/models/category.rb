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

class Category < ApplicationRecord
  # Enum
  enum :collection_type, [:manual, :automated]

  # Relationship
  has_many :products, dependent: :destroy

  # Validation
  validates :title, presence: true, uniqueness: true
end
