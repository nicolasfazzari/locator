json.array!(@boites) do |boite|
  json.extract! boite, :id, :departement, :zip, :commune, :boite, :latitude, :longitude
  json.url boite_url(boite, format: :json)
end
