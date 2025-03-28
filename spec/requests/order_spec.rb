require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /index" do
    before do
      orders = create_list(:order, 5)
      @user = create(:user)
      @product = create(:product) 
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

    # HTML Request + valid Request
    it "Should a create a new order with valid params" do
      order_params = {:order=>{quantity: 10, user_id: @user.id, product_id: @product.id}}
      post orders_path, params: order_params
      
      # Response type
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response).to have_http_status(:found)
      expect(Order.count).to eq(6)
    end

    # JSON Request + valid Request
    it "Should a create a new order with valid params with json request" do
      order_params = {:order=>{quantity: 10, user_id: @user.id, product_id: @product.id}}
      post orders_path, params: order_params, as: :json
      
      # Response type
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["quantity"]).to eq(order_params[:order][:quantity])
      expect(Order.count).to eq(6)
    end

    # JSON Request + invalid Params
    it "Invalid with user" do
      order_params = {:order=>{quantity: 10, product_id: @product.id}}
      post orders_path, params: order_params, as: :json

      json_response = JSON.parse(response.body)
      expect(response.content_type).to include("application/json")
      expect(json_response["user"]).to include("must exist", "can't be blank")
    end
    
    # JSON Request + invalid Params
    it "Invalid with product" do
      order_params = {:order=>{quantity: 10, user_id: @user.id}}
      post orders_path, params: order_params, as: :json

      json_response = JSON.parse(response.body)
      expect(response.content_type).to include("application/json")
      expect(json_response["product"]).to include("must exist")
    end

    # HTML Request + invalid Params
    it "Invalid with product" do
      order_params = {:order=>{quantity: 10, user_id: @user.id}}
      post orders_path, params: order_params

      expect(response.content_type).to include("text/html; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Product must exist")
    end

    # HTML PATCH + Update Request
    it "updates order with valid params" do
      order = create(:order)
      order_params = {:order=>{id: order.id, quantity: 22}}
      patch order_path(order), params: order_params

      order.reload
      expect(order.quantity).to eq(22)
      expect(response.content_type).to include("text/html; charset=utf-8")
    end 

    # JSON PATCH + Update Request
    it "Update order with valid prams with JSON request" do 
      order = create(:order)
      order_params = {:order=>{id: order.id, quantity: 24}}
      patch order_path(order), params: order_params, as: :json
      
      order.reload
      expect(order.quantity).to be(24)
      expect(response.content_type).to include("application/json; charset=utf-8")
    end


    # HTML PUT + Update Request
    it "updates order with valid params" do
      order = create(:order)
      order_params = {:order=>{id: order.id, quantity: 22}}
      put order_path(order), params: order_params

      order.reload
      expect(order.quantity).to eq(22)
      expect(response.content_type).to include("text/html; charset=utf-8")
    end 

    # JSON PUT + Update Request
    it "Update order with valid prams with JSON request" do 
      order = create(:order)
      order_params = {:order=>{id: order.id, quantity: 24}}
      put order_path(order), params: order_params, as: :json
      
      order.reload
      expect(order.quantity).to be(24)
      expect(response.content_type).to include("application/json; charset=utf-8")
    end

    it "HTML with delete" do
      order = create(:order)
      expect { delete order_path(order) }.to change(Order, :count).by(-1)
    end

    it "deletes a user and confirms deletion" do
      order = create(:order)
      delete order_path(order)
      expect(Order.exists?(order.id)).to be_falsey # Ensure order is removed
    end
  end
end
