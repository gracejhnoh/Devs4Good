class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.text :description
      t.boolean :selected?

      t.timestamps
    end
  end
end
