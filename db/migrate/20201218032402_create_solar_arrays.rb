class CreateSolarArrays < ActiveRecord::Migration[6.0]
  def change
    create_table :solar_arrays do |t|
      t.string :name
      t.integer :owner_id
      t.string :utility
      t.string :zone
      t.string :meter_type
      t.string :state
      t.string :country
      t.integer :annual_capacity
      t.string :status

      t.timestamps
    end
  end
end
