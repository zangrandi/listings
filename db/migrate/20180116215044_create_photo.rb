class CreatePhoto < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :listing_id, index: true
      t.attachment :attachment
    end
  end
end
