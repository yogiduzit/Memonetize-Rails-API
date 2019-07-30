class RemoveUrlFromMeme < ActiveRecord::Migration[5.2]
  def change
    remove_column 'memes', 'img_url'
  end
end
