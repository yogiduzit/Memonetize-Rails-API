class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :vote_type
      t.references :user, foreign_key: true
      t.references :meme, foreign_key: true
      t.timestamps
    end
  end
end
