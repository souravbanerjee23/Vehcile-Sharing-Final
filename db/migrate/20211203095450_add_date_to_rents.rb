class AddDateToRents < ActiveRecord::Migration[6.1]
  def change
    add_column :rents, :date, :datetime
  end
end
