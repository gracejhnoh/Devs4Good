require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'new_proposal_email' do
    let!(:organization) { FactoryGirl.create(:organization)}
    let!(:developer) { FactoryGirl.create(:developer)}
    let!(:project) { FactoryGirl.create(:project)}
    let!(:proposal) { FactoryGirl.create(:proposal)}
    let!(:mail) { UserMailer.new_proposal_email(organization, proposal)}

    it 'renders the subject' do
      expect(mail.subject).to eq('You have a new proposal for your project!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq (['devs4good@gmail.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq (['devs4good@gmail.com'])
    end
  end

end
