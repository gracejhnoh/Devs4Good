class UserMailer < ApplicationMailer
  default from: 'devs4good@gmail.com'

  def new_proposal_email(organization, proposal)
    @organization = organization
    @proposal = proposal
    mail(to: 'devs4good@gmail.com', subject: 'You have a new proposal for your project!')
  end

  def proposal_selected_email(developer, proposal)
    @developer = developer
    @proposal = proposal
    mail(to: 'devs4good@gmail.com', subject: 'Your proposal was selected!')
  end
end
