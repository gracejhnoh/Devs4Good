require 'rails_helper'

describe UsersController do

  describe "get users/new " do
    it "responds 200" do
      get :new
      expect(response.status).to eq(200)
    end

    it "sends to account creation page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "post developers" do
    before(:each) do
      post :create, params: { user: {first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      user_type: 'dev',
      email: Faker::Internet.safe_email,
      password: Faker::Internet.password,
      website: Faker::Internet.domain_name,
      description: Faker::StarWars.quote,
      phone: Faker::PhoneNumber.cell_phone
      }
    }
    end
    it "responds 302" do
      expect(response).to have_http_status(302)
    end
  end
end
