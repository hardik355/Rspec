require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /index" do
    before do
      orders = create_list(:order, 5) 
    end 

    it "fetch all orders" do
      get orders_path
      expect(response).to have_http_status(:ok)
    end

    it "New Order Request" do
      get new_order_path
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response).to render_template(:new)
    end

    # HTML Request
    it "Should a create a new order with valid params" do
      user = create(:user)
      product = create(:product) 
      order_params = {:order=>{quantity: 10, user_id: user.id, product_id: product.id}}
      post orders_path, params: order_params
      
      # Response type
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response).to have_http_status(:found)
      expect(Order.count).to eq(6)
    end

    # JSON Request
    it "Should a create a new order with valid params with json request" do
      user = create(:user)
      product = create(:product) 
      order_params = {:order=>{quantity: 10, user_id: user.id, product_id: product.id}}
      post orders_path, params: order_params, as: :json
      
      # Response type
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["quantity"]).to eq(order_params[:order][:quantity])
      expect(Order.count).to eq(6)
    end
    

  end
end
