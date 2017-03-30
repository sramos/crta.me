class CreateHits < ActiveRecord::Migration[5.0]
  def change
    create_table :hits do |t|
      t.string :ip_address
      t.string :referer
      t.references :url, index: true
      t.timestamps
    end
  end
end
