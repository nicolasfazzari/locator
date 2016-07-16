class AddPhoneToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :phone, :integer
  end
end
