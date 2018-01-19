class CHangeListingColumn < ActiveRecord::Migration[5.1]
  def up
    change_column :listings, :price, :integer
  end

  def down
    change_column :listings, :price, :decimal
  end
end
