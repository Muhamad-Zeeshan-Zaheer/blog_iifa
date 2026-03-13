class RemovePartNumberFromProducts < ActiveRecord::Migration[7.2]
  def change
    remove_column :products, :part_number, :string
  end
end
