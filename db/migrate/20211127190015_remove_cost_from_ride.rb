class RemoveCostFromRide < ActiveRecord::Migration[6.1]
  def change
    remove_column :rides, :cost, :string
  end
end
