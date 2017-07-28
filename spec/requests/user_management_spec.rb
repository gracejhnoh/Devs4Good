require 'rails_helper'

RSpec.describe "User management", :type => :request do

  it "render's users new page through developer's path" do
    get "/developers/new"
    expect(response).to render_template(:new)
  end

  it "render's users new page through organization's path" do
    get "/organizations/new"
    expect(response).to render_template(:new)
  end
end
