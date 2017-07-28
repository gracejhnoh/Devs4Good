require 'rails_helper'

describe User do
  let(:developer) { FactoryGirl.create(:developer) }

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
  end
end
