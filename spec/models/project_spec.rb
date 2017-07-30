require 'rails_helper'

describe Project do

  context 'validates' do
    it { is_expected.to validate_presence_of :description }

    it { is_expected.to validate_presence_of :title }

    it { is_expected.to validate_presence_of :time_frame }
  end

  context 'selected proposal' do
    let!(:developer) { FactoryGirl.create(:developer) }
    let!(:organization) { FactoryGirl.create(:organization) }
    let!(:project) { FactoryGirl.create(:project) }
    let!(:proposal) { FactoryGirl.create(:proposal, project: project, developer: developer) }

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
