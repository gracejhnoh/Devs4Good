require 'rails_helper'

describe SessionsController do
  let!(:user) { FactoryGirl.create(:developer) }

  context 'get #new' do
    it 'responds with 200' do
      get :new
      expect(response).to have_http_status 200
    end

    it 'renders a new page' do
      get :new
      expect(response).to render_template :new
    end
  end

  context 'post #create with valid credenitals' do
    before(:each) do
      post :create, params: { user: { email: user.email, password: 'password123' } }
    end
    after(:each) do
      delete :destroy
    end

    it 'responds with 302 if valid login' do
      expect(response).to have_http_status 302
    end

    it 'redirects to home if valid login' do
      expect(response).to redirect_to root_path
    end

    it 'create current_user if valid login' do
      expect(controller.current_user).to be_present
    end
  end

  context 'post #create with invalid credenitals' do
    before(:each) do
      post :create, params: { user: { email: user.email, password: 'wrong_password' } }
    end
    after(:each) do
      delete :destroy
    end

    it 'responds with 401 if invalid login' do
      expect(response).to have_http_status 401
    end

    it 'redirects to new template if invalid login' do
      expect(response).to render_template :new
    end

    it 'does not create current_user if invalid login' do
      expect(controller.current_user).to_not be_present
    end
  end

  context 'delete #destroy' do
    before(:each) do
      post :create, params: { user: { email: user.email, password: 'password123' } }
      delete :destroy
    end

    it 'responds with 302' do
      expect(response).to have_http_status 302
    end

    it 'does not have a current_user anymore' do
      expect(controller.current_user).to_not be_present
    end
  end
end