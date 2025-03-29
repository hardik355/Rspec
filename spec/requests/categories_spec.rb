require 'rails_helper'

RSpec.describe "Categories", type: :request do
  before do
    categories = create_list(:category, 10) 
  end

  # Index
  it "get list of categories" do
    get categories_path
    expect(response).to have_http_status(:ok) 
  end

  # new
  it "Category new request" do
    get new_category_path
    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to render_template(:new) 
  end

  # HTML + create a record with valid params
  it "Create a category record with valid data" do
    user = create(:user)
    product = create(:product)
    category_params = {
      category: {
        title: "Electric", 
        handle: "_electric", 
        collection_type: "manual", 
        rules: "Aut dolor aperiam provident."
      }
    }

    post categories_path, params: category_params
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    expect(Category.count).to eq(12)

  end

  it "Update Category with new data" do
    category = create(:category)
    category_params = {category:{title: "This is updated"}}

    put category_path(category), params: category_params
    expect(response.content_type).to eq("text/html; charset=utf-8")
    category.reload

    expect(category.title).to eq("This is updated")
  end

  it "destoy record" do
    category = create(:category)
    delete category_path(category)
    expect(Category.exists?(category.id)).to be_falsey
  end

end
