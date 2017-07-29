class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :proposals, :selected?, :selected
  end
end
