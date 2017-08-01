class AddEinToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ein, :string
  end
end
