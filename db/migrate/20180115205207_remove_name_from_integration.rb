class RemoveNameFromIntegration < ActiveRecord::Migration[5.1]
  def change
    remove_column :integrations, :name, :string
    add_column :integrations, :identifier, :string
  end
end
