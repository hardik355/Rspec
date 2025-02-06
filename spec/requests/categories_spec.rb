require 'rails_helper'

RSpec.describe "Categories", type: :request do
  
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

  end
end
