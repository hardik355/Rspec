json.extract! product, :id, :title, :price, :description, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
