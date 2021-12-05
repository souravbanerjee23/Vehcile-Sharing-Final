class AddPhoneToOwners < ActiveRecord::Migration[6.1]
  def change
    add_column :owners, :phone, :string
  end
end
