class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
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

      t.timestamps
    end
  end
end
