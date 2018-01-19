class AddListingIdToIntegration < ActiveRecord::Migration[5.1]
  def change
    add_column :integrations, :listing_id, :integer, index: true
  end
end
