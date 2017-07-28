class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :organization_id
      t.text :description
      t.date :time_frame
      t.string :title

      t.timestamps
    end
  end
end
