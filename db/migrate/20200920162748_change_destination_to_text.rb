class ChangeDestinationToText < ActiveRecord::Migration[5.0]
  def change
    change_column :stored_urls, :destination, :text
  end
end
