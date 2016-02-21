class BeermappingApi
	def self.places_in(city)
		return "" if city==""
		city = city.downcase
		Rails.cache.fetch(city, expires_in:1.week, race_condition_ttl:5.minutes) { fetch_places_in(city) }
	end
	
    	private
	def self.fetch_places_in(city)
		url = "http://beermapping.com/webservice/loccity/#{key}/"

		response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
		places = response.parsed_response["bmp_locations"]["location"]

		return [] if places.is_a?(Hash) and places['id'].nil?

		places = [places] if places.is_a?(Hash)
		places.map do | place |
			Place.new(place)
		end
	end

	def self.fetch_by_id(id)
		url = "http://beermapping.com/webservice/locquery/#{key}/"

		response = HTTParty.get "#{url}#{ERB::Util.url_encode(id)}"
		place = response.parsed_response["bmp_locations"]["location"]
	end


	def self.key
		raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
		ENV['APIKEY']
	end
end
