class CreateBoites < ActiveRecord::Migration
  def change
    create_table :boites do |t|
      t.string :departement
      t.integer :zip
      t.string :commune
      t.string :boite
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
