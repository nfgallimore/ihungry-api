class AddUniqueConstraintToUpc < ActiveRecord::Migration[5.2]
  def change
    add_index :upcs, [:upc_string], :unique => true
  end
end
