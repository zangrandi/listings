class CreateCredential < ActiveRecord::Migration[5.1]
  def change
    remove_column :integrations, :listing_id, :integer
    remove_column :integrations, :identifier, :string
    rename_column :integrations, :type, :name
    add_column :integrations, :username, :string
    add_column :integrations, :password, :string
    create_table :listing_integrations do |t|
      t.integer :integration_id, index: true
      t.integer :listing_id, index: true
      t.string :identifier
      t.string :type
    end
  end
end
