class AddSummariesToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :summary, :string, default: '(no summary provided)', null: false
    change_column :projects, :summary, :string, default: nil
  end
end
