class CreateMemeTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :meme_taggings do |t|
      t.references :meme, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
