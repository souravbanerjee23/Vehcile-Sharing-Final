class CreatePassengers < ActiveRecord::Migration[6.1]
  def change
    create_table :passengers do |t|
      t.string :email, null:false
      t.string :phone, null:false
      t.string :password_digest

      t.timestamps
    end
  end
end
