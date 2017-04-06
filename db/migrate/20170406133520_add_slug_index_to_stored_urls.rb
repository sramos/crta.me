class AddSlugIndexToStoredUrls < ActiveRecord::Migration[5.0]
  def change
    add_index :stored_urls, :slug, unique: true
  end
end
