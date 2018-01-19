class AddAddressToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :street, :string
    add_column :listings, :number, :string
    add_column :listings, :complement, :string
  end
end
