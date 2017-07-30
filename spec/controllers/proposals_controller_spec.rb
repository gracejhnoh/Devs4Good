require 'rails_helper'

RSpec.describe ProposalsController, type: :controller do

  describe 'POST #create' do
    let!(:user) { FactoryGirl.create(:developer) }
    let!(:new_organization) { FactoryGirl.create(:organization) }
    let!(:test_project) { FactoryGirl.create(:project) }
    before(:each) do
      @user = user
      login_user(user)
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

  describe 'PATCH#update' do

    context 'selecting proposal' do
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:proposal) { FactoryGirl.create(:proposal, project: project, developer: developer) }
      before(:each) do
        patch :update, params: { project_id: project.id, id: proposal.id, proposal: { selected: true } }
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
    end
  end

end
