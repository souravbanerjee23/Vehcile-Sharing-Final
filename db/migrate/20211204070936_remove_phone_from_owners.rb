class RemovePhoneFromOwners < ActiveRecord::Migration[6.1]
  def change
    remove_column :owners, :phone, :integer
  end
end
