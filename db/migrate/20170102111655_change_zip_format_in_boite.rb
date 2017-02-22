class ChangeZipFormatInBoite < ActiveRecord::Migration
  def up
    	change_column :boites, :zip, :string
  	end

  	def down
    	change_column :boites, :zip, :integer
  	end
end
