class CreateUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
      t.string :destination
      t.string :slug
      t.integer :hits, default: 0
      t.timestamps
    end
  end
end
