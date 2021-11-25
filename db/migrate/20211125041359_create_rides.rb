class CreateRides < ActiveRecord::Migration[6.1]
  def change
    create_table :rides do |t|
      t.string :vehicle_no
      t.integer :seats
      t.string :start_point
      t.string :stop1
      t.string :stop2
      t.string :stop3
      t.string :stop4
      t.string :final_stop
      t.string :cost
      t.string :integer
      t.integer :discount
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
