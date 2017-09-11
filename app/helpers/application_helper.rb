module ApplicationHelper
  def is_dev?
    current_user.user_type == 'dev'
  end

  def is_project_org?
    @project.organization.id == current_user.id
  end

  def has_contact_email?
    @project.contact_email != ''
  end
end
