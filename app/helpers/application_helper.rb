module ApplicationHelper
  def is_dev?
    current_user.user_type == 'dev'
  end

  def is_project_org?
    @project.organization.id == current_user.id
  end

  def is_proposal_dev?
    @proposal.developer.id == current_user.id
  end

  def has_contact_email?
    @project.contact_email != ''
  end

  def missing_ein?
    @user.ein == '' || @user.ein == nil
  end
end
