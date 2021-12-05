class AddDateToRide < ActiveRecord::Migration[6.1]
  def change
    add_column :rides, :date, :datetime
  end
end
