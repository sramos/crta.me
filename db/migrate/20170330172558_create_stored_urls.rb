class CreateStoredUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :stored_urls do |t|
      t.string :destination
      t.string :slug
      t.timestamps
    end
  end
end
