class AddVehicleTypeToRide < ActiveRecord::Migration[6.1]
  def change
    add_column :rides, :vehicletype, :string
  end
end
