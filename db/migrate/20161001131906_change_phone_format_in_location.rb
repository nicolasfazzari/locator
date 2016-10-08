class ChangePhoneFormatInLocation < ActiveRecord::Migration
  def up
    change_column :locations, :phone, :text
  end

  def down
    change_column :locations, :phone, :integer
  end
end
