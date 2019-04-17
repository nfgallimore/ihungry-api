class CreateUpcs < ActiveRecord::Migration[5.2]
  def change
    create_table :upcs do |t|
      t.string :upc

      t.timestamps
    end
  end
end
