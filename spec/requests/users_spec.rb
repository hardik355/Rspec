require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    before do
      create_list(:user, 5)
    end
    
    it "Return a list of users" do
      get users_path 
      expect(response).to have_http_status(:ok)
    end

    it "Should render new page" do
      get new_user_path
      # Check if the response status is 200 OK
      expect(response).to have_http_status(:ok)
            
      # Check if the response content type is HTML
      expect(response.content_type).to eq("text/html; charset=utf-8")

      # Check if the correct template is rendered
      expect(response).to render_template(:new)
    end


    it "Should create a valid record with HTML request" do
      user_params = { user: attributes_for(:user) }
      post users_path, params: user_params
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(user_path(User.last))
      expect(User.count).to eq(6) 
    end

    it "Should create a valid record with json json" do
      user_params = { user: attributes_for(:user) }
      post users_path, params: user_params, as: :json
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq(user_params[:user][:name])
      expect(User.count).to eq(6) 
    end

    it "Invalid param" do
      invalid_params = { user: {name: "", email: ""}}
      post users_path, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity) 
      expect(User.count).to eq(5)
    end

    it "Invalid param" do
      invalid_params = { user: {name: "", email: ""}}
      post users_path, params: invalid_params, as: :json
      expect(response).to have_http_status(:unprocessable_entity) 
      expect(User.count).to eq(5)

      parsed_response = JSON.parse(response.body) # Parse JSON response
      expect(parsed_response["name"]).to include("can't be blank") # Use string keys
      expect(parsed_response["email"]).to include("can't be blank") # Validate email errors
    end
  end
end
