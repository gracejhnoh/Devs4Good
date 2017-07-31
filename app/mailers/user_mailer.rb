class UserMailer < ApplicationMailer
  default from: 'devs4good@gmail.com'

  def new_proposal_email(organization, proposal)
    p 'hello world'
    @organization = organization
    @proposal = proposal
    mail(to: 'devs4good@gmail.com', subject: 'You have a new proposal for your project!')
  end
end
