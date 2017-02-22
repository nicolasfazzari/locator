namespace :search_suggestions do
	desc "Generate search suggestions from boite"
	task :index => :environment do
		SearchSuggestion.index_boites
	end
end