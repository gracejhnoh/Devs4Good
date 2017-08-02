class AddImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image_uid, :string
    add_column :users, :image_name, :string
  end
end
