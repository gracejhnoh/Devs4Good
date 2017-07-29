class FixColumnDataType < ActiveRecord::Migration[5.1]
  def change
    change_column :proposals, :selected, :boolean, default: false
  end
end
