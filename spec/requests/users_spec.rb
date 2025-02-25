require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    before do
      create_list(:user, 5)
    end
  
    # Index
    it "Return a list of users" do
      get users_path 
      expect(response).to have_http_status(:ok)
    end

    # New
    it "Should render new page" do
      get new_user_path
      # Check if the response status is 200 OK
      expect(response).to have_http_status(:ok)
            
      # Check if the response content type is HTML
      expect(response.content_type).to eq("text/html; charset=utf-8")

      # Check if the correct template is rendered
      expect(response).to render_template(:new)
    end

    #HTML
    it "Should create a valid record with HTML request" do
      user_params = { user: attributes_for(:user) }
      post users_path, params: user_params
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(user_path(User.last))
      expect(User.count).to eq(6) 
    end

    # JSON
    it "Should create a valid record with json" do
      user_params = { user: attributes_for(:user) }
      post users_path, params: user_params, as: :json
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["first_name"]).to eq(user_params[:user][:first_name])
      expect(User.count).to eq(6) 
    end

    # INVALID PARAMS
    it "Invalid param" do
      invalid_params = { user: {first_name: "", email: ""}}
      post users_path, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity) 
      expect(User.count).to eq(5)
    end

    # INVALID PARAMS
    it "Invalid param" do
      invalid_params = { user: {first_name: "", email: ""}}
      post users_path, params: invalid_params, as: :json
      expect(response).to have_http_status(:unprocessable_entity) 
      expect(User.count).to eq(5)

      parsed_response = JSON.parse(response.body) # Parse JSON response
      expect(parsed_response["first_name"]).to include("can't be blank") # Use string keys
      expect(parsed_response["email"]).to include("can't be blank") # Validate email errors
    end

    # Update Patch
    it "it should be update user" do
      user = create(:user)
      
      updated_params = {user: {first_name: "richard"}}

      patch user_path(user), params: updated_params, as: :json
      expect(response).to have_http_status(:ok)
      user.reload
      expect(user.first_name).to eq("richard")
      expect(user.email).to eq(user.email)
    end
    
    # Put
    it "it should be update user" do
      user = create(:user)
      
      updated_params = {user: {first_name: "richard", email: "richard355@gmail.com"}}

      put user_path(user), params: updated_params, as: :json
      expect(response).to have_http_status(:ok)
      user.reload
      expect(user.first_name).to eq("richard")
      expect(user.email).to eq("richard355@gmail.com")
    end

    # Delete
    it "is should be delete" do
      user = create(:user)  
      
      expect {delete user_path(user)}.to change(User, :count).by(-1)
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(users_path)
    end

    # Delete
    it "deletes a user and confirms deletion" do
      user = create(:user)
    
      delete user_path(user)
    
      expect(response).to have_http_status(:see_other)
      expect(User.exists?(user.id)).to be_falsey # Ensure user is removed
    end
  end
end
