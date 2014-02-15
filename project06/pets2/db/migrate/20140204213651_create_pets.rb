class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.text :name
      t.integer :age
      t.text :primaryType
      t.text :secondaryType
      t.string :image

      t.timestamps
    end
  end
end
