class Location < ActiveRecord::Base
	
	geocoded_by :address
	geocoded_by :full_address
	after_validation :geocode

	def full_address
		"#{address},#{zip},#{city}"
	end
end
