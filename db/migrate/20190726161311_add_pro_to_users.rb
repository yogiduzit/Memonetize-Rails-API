class AddProToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_pro, :boolean, default: false
  end
end
