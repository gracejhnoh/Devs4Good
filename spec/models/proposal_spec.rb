require 'rails_helper'

describe Proposal do
  context 'validations' do
    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_presence_of :project_id }

    it { is_expected.to validate_presence_of :description }
  end

  context 'selected proposal' do
    let!(:developer) { FactoryGirl.create(:developer) }
    let!(:organization) { FactoryGirl.create(:organization) }
    let!(:project) { FactoryGirl.create(:project) }
    let!(:proposal) { FactoryGirl.create(:proposal, project_id: project.id, user_id: developer.id) }

    it 'returns nil if no proposal selected' do
      expect(project.selected_proposal).to be_nil
    end

    it 'returns the selected project' do
      proposal.selected = true
      proposal.save
      expect(project.selected_proposal).to eq proposal
    end
  end
end
