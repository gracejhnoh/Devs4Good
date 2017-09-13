require 'rails_helper'

describe User do
  let!(:developer) { FactoryGirl.create(:developer) }
  let!(:organization) { FactoryGirl.create(:organization)}
  let!(:project_one) { FactoryGirl.create(:project) }
  let!(:selected_proposal) { FactoryGirl.create(:proposal, project_id: project_one.id, user_id: developer.id, selected: true) }
  let!(:unselected_proposal) { FactoryGirl.create(:proposal, project_id: project_one.id, user_id: developer.id) }
  let!(:organization) { FactoryGirl.create(:organization) }

  context "developer" do
    describe "attributes" do
      it "has a first name" do
        expect(developer.first_name).not_to be_nil
      end

      it "has a last name" do
        expect(developer.last_name).not_to be_nil
      end

      it "has a user type of dev" do
        expect(developer.user_type).to eq 'dev'
      end

      it "has an email" do
        expect(developer.email).not_to be_nil
      end

      it "has an encripted password" do
        expect(developer.crypted_password).not_to be_nil
      end

      it "has a website" do
        expect(developer.website).not_to be_nil
      end

      it "has a description" do
        expect(developer.website).not_to be_nil
      end

      it "has a phone" do
        expect(developer.phone).not_to be_nil
      end

      it "does not have an org name" do
        expect(developer.org_name).to be_nil
      end

      it "does not have an street address" do
        expect(developer.street_address).to be_nil
      end

      it "does not have a city" do
        expect(developer.city).to be_nil
      end

      it "does not have a state" do
        expect(developer.state).to be_nil
      end

      it "does not have a zip code" do
        expect(developer.zip).to be_nil
      end
    end

    describe 'validations' do
      let(:invalid_developer) { FactoryGirl.build(:developer) }

      it 'is invalid with misformatted email' do
        invalid_developer.email = 'abc@123'
        expect(invalid_developer).not_to be_valid
      end

      it 'is invalid with misformatted phone' do
        invalid_developer.phone = '(502)344-9899'
        expect(invalid_developer).not_to be_valid
      end

      it 'is invalid with misformatted website' do
          invalid_developer.website = 'www.beandolphins.com'
          expect(invalid_developer).not_to be_valid
      end

      it 'is invalid without first name' do
        invalid_developer.first_name = ''
        expect(invalid_developer).not_to be_valid
      end

      it 'is invalid without last name' do
        invalid_developer.last_name = ''
        expect(invalid_developer).not_to be_valid
      end

      it 'is invalid without email' do
        invalid_developer.email = ''
        expect(invalid_developer).not_to be_valid
      end

      it 'is invalid without password' do
        invalid_developer.password = ''
        expect(invalid_developer).not_to be_valid
      end
    end

    describe '#selected_proposals' do
      it 'returns selected proposals' do
        expect(developer.selected_proposals).to eq ([selected_proposal])
      end

      it 'does not returned unselected proposals' do
        expect(developer.selected_proposals).not_to include(unselected_proposal)
      end
    end
  end

  context "organization" do
    describe "attributes" do
      it "has an org name" do
        expect(organization.org_name).not_to be_nil
      end

      it 'has an EIN number' do
        expect(organization.ein).not_to be_nil
      end

      it "has a street address" do
        expect(organization.street_address).not_to be_nil
      end

      it "has a city" do
        expect(organization.city).not_to be_nil
      end

      it "has a state" do
        expect(organization.state).not_to be_nil
      end

      it "has a zip" do
        expect(organization.zip).not_to be_nil
      end

      it "has a user type of org" do
        expect(organization.user_type).to eq 'org'
      end

      it "has an email" do
        expect(organization.email).not_to be_nil
      end

      it "has an encripted password" do
        expect(organization.crypted_password).not_to be_nil
      end

      it "has a website" do
        expect(organization.website).not_to be_nil
      end

      it "has a description" do
        expect(organization.website).not_to be_nil
      end

      it "has a phone" do
        expect(organization.phone).not_to be_nil
      end

      it "does not have a first name" do
        expect(organization.first_name).to be_nil
      end

      it "does not have a last name" do
        expect(organization.last_name).to be_nil
      end
    end

    describe 'validations' do
      let(:invalid_organization) { FactoryGirl.build(:organization) }

      it 'is invalid without org name' do
        invalid_organization.org_name = ''
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid with wrong EIN format' do
        invalid_organization.ein = '12-3456789'
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid with misformatted state' do
        invalid_organization.state = "Arizona"
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid with misformatted zip' do
        invalid_organization.zip = "989978"
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid with misformatted phone' do
        invalid_organization.phone = "1235467897"
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid with misformatted website' do
        invalid_organization.website = "www.beandolphins.com"
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid without street address' do
        invalid_organization.street_address = ''
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid without city' do
        invalid_organization.city = ''
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid without state' do
        invalid_organization.state = ''
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid without zip' do
        invalid_organization.zip = ''
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid without email' do
        invalid_organization.email = ''
        expect(invalid_organization).not_to be_valid
      end

      it 'is invalid without password' do
        invalid_organization.password = ''
        expect(invalid_organization).not_to be_valid
      end
    end
  end
end
