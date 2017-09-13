require 'rails_helper'

RSpec.describe ProposalsController, type: :controller do

  describe 'GET #new' do
    let!(:dev) { FactoryGirl.create(:developer) }
    let!(:org) { FactoryGirl.create(:organization) }
    let!(:test_project) { FactoryGirl.create(:project) }

    it 'redirects an organization' do
      login_user(org)
      get :new, params: { project_id: test_project.id }
      expect(response.status).to eq 302
    end

    it 'assigns an empty proposal to @proposal' do
      login_user(dev)
      get :new, params: { project_id: test_project.id }
      expect(assigns[:proposal]).to be_a Proposal
    end
  end

  describe 'POST #create' do
    let!(:user) { FactoryGirl.create(:developer) }
    let!(:new_organization) { FactoryGirl.create(:organization) }
    let!(:test_project) { FactoryGirl.create(:project) }
    before(:each) do
      login_user(user)
    end
    after(:each) do
      logout_user
    end

    it 'returns a status code of 302' do
      post :create, params: { project_id: test_project.id, proposal: FactoryGirl.attributes_for(:proposal) }
      expect(response.status).to eq 302
    end

    context 'with valid attributes' do
      it 'creates a new proposal' do
        expect {
          post :create, params: { project_id: test_project.id, proposal: FactoryGirl.attributes_for(:proposal)
        } }.to change{Proposal.all.count}.by 1
      end

      it 'returns a status code of 302' do
        post :create,  params: { project_id: test_project.id, proposal: FactoryGirl.attributes_for(:proposal) }
        expect(response).to have_http_status 302
      end

      it 'redirects to the proposals show page' do
        post :create,  params: { project_id: test_project.id, proposal: FactoryGirl.attributes_for(:proposal) }
        expect(response).to redirect_to project_proposal_path(project_id: test_project.id, id: Proposal.last.id)
      end

      it 'sends an ActionMailer email' do
        expect {
          post :create, params: { project_id: test_project.id, proposal: FactoryGirl.attributes_for(:proposal)
        } }.to change{ ActionMailer::Base.deliveries.count }.by 1
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new proposal' do
        expect{ post :create, params: { project_id: test_project.id, proposal: { description: nil, user_id: 2 } } }.not_to change{ Proposal.all.count }
      end

      it 'renders the new proposal view' do
        post :create, params: { project_id: test_project.id, proposal: { description: nil, user_id: 2 } }
        expect(response).to render_template(:new)
      end
    end
  end


    describe 'GET#show' do
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:test_project) { FactoryGirl.create(:project) }
      let!(:new_proposal) { FactoryGirl.create(:proposal) }
      before(:each) do
        login_user(developer)
      end
      after(:each) do
        logout_user
      end

      it "returns a status of 200" do
        get :show, params: { project_id: test_project.id, id: new_proposal.id }
        expect(response).to have_http_status 200
      end

      it "renders a show page" do
        get :show, params: { project_id: test_project.id, id: new_proposal.id }
        expect(response).to render_template :show
      end

    end

    describe 'Delete #destroy' do
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:test_project) { FactoryGirl.create(:project) }
      let!(:new_proposal) { FactoryGirl.create(:proposal) }
      before(:each) do
        login_user(developer)
      end
      after(:each) do
        logout_user
      end

      it 'responds with a status code 302' do
        delete :destroy, params: { project_id: test_project.id, id: new_proposal.id}
        expect(response).to have_http_status 302
      end

      it 'destroyed the requested proposal' do
        expect{ delete :destroy, params: { project_id: test_project.id, id: new_proposal.id } }.to change(Proposal, :count).by (-1)
      end

      it 'redirects back to the organization show page' do
        delete :destroy, params: { project_id: test_project.id, id: new_proposal.id }
        expect(response).to redirect_to organization_project_path(new_proposal.project.organization_id, new_proposal.project_id)
      end

      it 'redirects if the user is an organization' do
        logout_user
        login_user(organization)
        delete :destroy, params: { project_id: test_project.id, id: new_proposal.id }
        expect(response).to redirect_to organization_path(organization)
      end
    end

    describe 'GET#edit' do
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:edit_proposal) { FactoryGirl.create(:proposal) }
      before(:each) do
        login_user(developer)
      end
      after(:each) do
        logout_user
      end

      it 'responds with status code 200' do
        get :edit, params: { project_id: project.id, id: edit_proposal.id }
        expect(response).to have_http_status 200
      end

      it 'renders an edit view' do
      get :edit, params: { project_id: project.id, id: edit_proposal.id  }
        expect(response).to render_template('edit')
      end

    end

  describe 'PATCH#update' do

    context 'Editing proposal' do
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:proposal) { FactoryGirl.create(:proposal, project_id: project.id, user_id: developer.id) }
      before(:each) do
        login_user(developer)
        patch :update, params: { project_id: project.id, id: proposal.id, proposal: { description: 'New awesome description'} }
      end
      after(:each) do
        logout_user
      end

      it 'returns 302' do
        expect(response).to have_http_status 302
      end

      it 'changes description of proposal' do
        expect(Proposal.find(proposal.id).description).to eq 'New awesome description'
      end

      it 'assigns the proposal to @proposal' do
        expect(assigns[:proposal]).to eq proposal
      end
    end

    context 'Editing proposal with invalid params' do
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:proposal) { FactoryGirl.create(:proposal, project_id: project.id, user_id: developer.id) }
      before(:each) do
        login_user(developer)
        patch :update, params: { project_id: project.id, id: proposal.id, proposal: { description: ''} }
      end
      after(:each) do
        logout_user
      end

      it 'does not change proposal description' do
        expect(Proposal.find(proposal.id).description).not_to eq('')
      end
    end

    context 'selecting proposal' do
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:proposal) { FactoryGirl.create(:proposal, project_id: project.id, user_id: developer.id) }
      before(:each) do
        login_user(organization)
        patch :update, params: { project_id: project.id, id: proposal.id, proposal: { selected: true } }
      end
      after(:each) do
        logout_user
      end

      it 'returns 302' do
        expect(response).to have_http_status 302
      end

      it 'changes proposal selected to true' do
        expect(Proposal.find(proposal.id).selected).to eq true
      end

      it 'assigns the proposal to @proposal' do
        expect(assigns[:proposal]).to eq proposal
      end

      it 'sends an ActionMailer email' do
        login_user(organization)
        expect{ patch :update, params: { project_id: project.id, id: proposal.id, proposal: { selected: true } } }.to change { ActionMailer::Base.deliveries.count }.by 1
      end
    end
    end
end
