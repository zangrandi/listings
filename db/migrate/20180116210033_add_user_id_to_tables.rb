class AddUserIdToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :user_id, :integer, index: true
    add_column :integrations, :user_id, :integer, index: true
  end
end
