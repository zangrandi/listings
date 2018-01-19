class AddPhoneToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :phone, :string
  end
end
