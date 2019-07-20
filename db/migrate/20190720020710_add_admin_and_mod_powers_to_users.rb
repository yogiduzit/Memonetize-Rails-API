class AddAdminAndModPowersToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_mod, :boolean, default: false
  end
end
