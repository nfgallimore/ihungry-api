class AddUniqueConstraintToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, [:name, :email], :unique => true
  end
end
