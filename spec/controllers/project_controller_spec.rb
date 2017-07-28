require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  context 'GET#index' do
    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    it 'assigns projects to @projects' do
      project = FactoryGirl.create(:project)
      get :index
      expect(assigns(:projects)).to eq([project])
    end

    it 'renders an index view' do
      get :index
      expect(response).to render_template('index')
    end
  end

end
