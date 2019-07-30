class AddUsersToMemes < ActiveRecord::Migration[5.2]
  def change
    add_reference :memes, :user, foreign_key: true
  end
end
