json.extract! order, :id, :quantity, :user_id, :product_id, :created_at, :updated_at
json.url order_url(order, format: :json)
