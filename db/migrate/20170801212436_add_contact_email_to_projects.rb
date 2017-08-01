class AddContactEmailToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :contact_email, :string
  end
end
