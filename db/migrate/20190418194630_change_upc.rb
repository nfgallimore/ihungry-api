class ChangeUpc < ActiveRecord::Migration[5.2]
  def change
    rename_column :upcs, :upc, :upc_string
  end
end
