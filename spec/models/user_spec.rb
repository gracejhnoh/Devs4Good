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
    end
  end
end
