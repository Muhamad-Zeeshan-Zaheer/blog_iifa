class AddPartNumberToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :part_number, :string
  end
end
