class CreateMemes < ActiveRecord::Migration[5.2]
  def change
    create_table :memes do |t|

      t.text :img_url
      t.text :title
      t.text :body

      t.timestamps

    end
  end
end
