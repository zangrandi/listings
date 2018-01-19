class AddColumnsToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :listing_subtype, :string
    add_column :listings, :transaction_type, :string
    add_column :integrations, :type, :string
  end
end
