class CreateListing < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :listing_type
      t.decimal :price
      t.string :state
      t.string :city
      t.string :reference
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :parking_spaces
      t.integer :square_feet
      t.string :district
      t.string :zipcode
    end
  end
end
