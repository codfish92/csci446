class AddFosterParentIdToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :fosterParent_id, :integer
  end
end
