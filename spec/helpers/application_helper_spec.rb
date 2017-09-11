require 'rails_helper'

describe ApplicationHelper do
  let!(:dev) { FactoryGirl.create(:developer) }
  let!(:org) { FactoryGirl.create(:organization) }
  let!(:test_project) { FactoryGirl.create(:project) }
  let!(:new_proposal) { FactoryGirl.create(:proposal) }

  describe "#is_dev?" do
    it "returns true if a dev" do
      allow(controller).to receive(:current_user).and_return(dev)
      expect(helper.is_dev?).to eq true
    end

    it 'returns false if not a dev' do
      allow(controller).to receive(:current_user).and_return(org)
      expect(helper.is_dev?).to eq false
    end
  end

  describe "is_project_org?" do
    it 'returns true if correct org'
  end
end
