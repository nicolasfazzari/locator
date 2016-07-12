class AddZipToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :zip, :integer
  end
end
