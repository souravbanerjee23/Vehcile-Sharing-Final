class AddCostToRide < ActiveRecord::Migration[6.1]
  def change
    add_column :rides, :cost, :integer
  end
end
