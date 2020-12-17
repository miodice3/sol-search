class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.integer :owner_id
      t.integer :consumer_id
      t.integer :asset_id
      t.string :status
      t.integer :capacity
      t.integer :term
      t.integer :rate

      t.timestamps
    end
  end
end
