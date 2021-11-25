class CreateRents < ActiveRecord::Migration[6.1]
  def change
    create_table :rents do |t|
      t.string :start_location
      t.string :destination
      t.integer :seats
      t.references :ride, null: false, foreign_key: true

      t.timestamps
    end
  end
end
