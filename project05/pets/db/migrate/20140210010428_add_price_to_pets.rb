class AddPriceToPets < ActiveRecord::Migration
  def change
    add_column :pets, :price, :decimal
  end
end
