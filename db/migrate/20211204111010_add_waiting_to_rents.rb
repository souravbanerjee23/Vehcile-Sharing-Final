class AddWaitingToRents < ActiveRecord::Migration[6.1]
  def change
    add_column :rents, :waiting, :boolean :default => false
  end
end
