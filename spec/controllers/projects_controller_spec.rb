require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  context 'GET#index' do
    let!(:organization) { FactoryGirl.create(:organization) }

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

  describe 'POST #create' do
    let!(:organization) { FactoryGirl.create(:organization) }
    let!(:organization2) { FactoryGirl.create(:organization)}
    let!(:developer) { FactoryGirl.create(:developer) }
    before(:each) do
      login_user(organization)
    end
    after(:each) do
      logout_user
    end

    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    context 'with valid attributes' do
      it 'creates a new project' do
        expect {
          post :create, params: { organization_id: organization.id, project: FactoryGirl.attributes_for(:project)
        } }.to change(Project, :count).by 1
      end

      it 'returns a status code of 302' do
        post :create,  params: { organization_id: organization.id, project: FactoryGirl.attributes_for(:project) }
        expect(response).to have_http_status 302
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new project' do
        expect {
          post :create, params: { organization_id: organization.id, project: { description: nil } } }.not_to change{ Project.all.count }
      end

      it 'renders the new projects view' do
        post :create, params: { organization_id: organization.id, project: { description: nil } }
        expect(response).to render_template(:new)
      end
    end

    it 'redirects if user is not the right organization' do
      logout_user
      login_user(organization2)
      post :create, params: { organization_id: organization.id, project: FactoryGirl.attributes_for(:project)}
      expect(response).to redirect_to organization_path(organization2)
    end

    it 'redirects if user is a developer' do
      logout_user
      login_user(developer)
      post :create, params: { organization_id: organization.id, project: FactoryGirl.attributes_for(:project)}
      expect(response).to redirect_to organization_path(developer)
    end

  end

  describe 'DELETE#destroy' do
    let!(:organization) { FactoryGirl.create(:organization) }
    let!(:test_project) { FactoryGirl.create(:project) }
    let!(:organization2) { FactoryGirl.create(:organization)}
    let!(:developer) { FactoryGirl.create(:developer) }
    before(:each) do
      login_user(organization)
    end
    after(:each) do
      logout_user
    end

    it 'responds with status code 302' do
      delete :destroy, params: { id: test_project.id, organization_id: organization.id }
      expect(response).to have_http_status 302
    end

    it 'destroys the requested project' do
      expect{ delete :destroy, params: { id: test_project.id, organization_id: organization.id } }.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects list' do
      delete :destroy, params: { id: test_project.id, organization_id: organization.id }
      expect(response).to redirect_to projects_path
    end

    it 'redirects if user is not the right organization' do
      logout_user
      login_user(organization2)
      delete :destroy, params: { id: test_project.id, organization_id: organization.id }
      expect(response).to redirect_to organization_path(organization2)
    end

    it 'redirects if user is a developer' do
      logout_user
      login_user(developer)
      delete :destroy, params: { id: test_project.id, organization_id: organization.id }
      expect(response).to redirect_to organization_path(developer)
    end
  end

  describe 'GET#edit' do
    let!(:organization) { FactoryGirl.create(:organization) }
    let!(:edit_project) { FactoryGirl.create(:project) }
    let!(:organization2) { FactoryGirl.create(:organization)}
    let!(:developer) { FactoryGirl.create(:developer) }
    before(:each) do
      login_user(organization)
    end
    after(:each) do
      logout_user
    end

    it 'responds with status code 200' do
      get :edit, params: { id: edit_project.id, organization_id: organization.id }
      expect(response).to have_http_status 200
    end

    it 'renders an edit view' do
      get :edit, params: { id: edit_project.id, organization_id: organization.id }
      expect(response).to render_template('edit')
    end

    it 'redirects if user is not the right organization' do
      logout_user
      login_user(organization2)
      get :edit, params: { id: edit_project.id, organization_id: organization.id }
      expect(response).to redirect_to organization_path(organization2)
    end

    it 'redirects if user is a developer' do
      logout_user
      login_user(developer)
      get :edit, params: { id: edit_project.id, organization_id: organization.id }
      expect(response).to redirect_to organization_path(developer)
    end
  end

  describe 'PUT#update' do
    let!(:organization) { FactoryGirl.create(:organization) }
    let!(:update_project) { FactoryGirl.create(:project) }
    let!(:organization2) { FactoryGirl.create(:organization)}
    let!(:developer) { FactoryGirl.create(:developer) }
    before(:each) do
      login_user(organization)
    end
    after(:each) do
      logout_user
    end

    it "updates an item with valid params" do
      patch :update, params: { id: update_project.id, organization_id: organization.id, project: {title: 'Updated title', description: 'blah', summary: 'bean dolphins', time_frame:"2017-08-03", contact_email: 'a@a.com' } }
      update_project.reload
      expect(update_project.title).to eq('Updated title')
    end

    it "does not update an item with invalid params(blanks)" do
      patch :update, params: { id: update_project.id, organization_id: organization.id, project: {title: 'Updated title', description: '', summary: 'great',  time_frame:"2017-08-03", contact_email: 'a@a.com'} }
      update_project.reload
      expect(response).to render_template('edit')
    end

    it 'redirects if user is not the right organization' do
      logout_user
      login_user(organization2)
      patch :update, params: { id: update_project.id, organization_id: organization.id, project: {title: 'Updated title', description: '', summary: 'great',  time_frame:"2017-08-03", contact_email: 'a@a.com'} }
      expect(response).to redirect_to organization_path(organization2)
    end

    it 'redirects if user is a developer' do
      logout_user
      login_user(developer)
      patch :update, params: { id: update_project.id, organization_id: organization.id, project: {title: 'Updated title', description: '', summary: 'great',  time_frame:"2017-08-03", contact_email: 'a@a.com'} }
      expect(response).to redirect_to organization_path(developer)
    end
  end

  describe 'GET#show' do
    let!(:organization) { FactoryGirl.create(:organization) }
    let!(:project) { FactoryGirl.create(:project) }
    let!(:developer) { FactoryGirl.create(:developer) }
    before(:each) do
      login_user(organization)
    end
    after(:each) do
      logout_user
    end

    it 'responds with status code 200' do
      get :show, params: { id: project.id, organization_id: organization.id }
      expect(response).to have_http_status 200
    end

    it 'renders a show view' do
      get :show, params: { id: project.id, organization_id: organization.id }
      expect(response).to render_template('show')
    end

    it 'redirects if specified user is not the same as path type' do
      get :show, params: { id: project.id, organization_id: developer.id }
      expect(response).to have_http_status 302
    end
  end

  describe 'GET#new' do
    let!(:organization) { FactoryGirl.create(:organization) }
    let!(:organization2) { FactoryGirl.create(:organization)}
    let!(:developer) { FactoryGirl.create(:developer) }
    before(:each) do
      login_user(organization)
    end
    after(:each) do
      logout_user
    end

    it 'responds with status code 200' do
      get :new, params: { organization_id: organization.id }
      expect(response).to have_http_status 200
    end

    it 'renders a new view' do
      get :new, params: { organization_id: organization.id }
      expect(response).to render_template('new')
    end

    it 'redirects if user is not the right organization' do
      logout_user
      login_user(organization2)
      get :new, params: { organization_id: organization.id }
      expect(response).to have_http_status 302
    end

    it 'redirects if user is a developer' do
      logout_user
      login_user(developer)
      get :new, params: { organization_id: organization.id }
      expect(response).to have_http_status 302
    end
  end

end
