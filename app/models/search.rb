class Search

	def by(intent,options)
		params = ""
		options.each do |v,k|
			params += "#{v}=#{k}&"
		end
		response = HTTParty.get(URI.encode("https://maps.googleapis.com/maps/api/place/radarsearch/json?#{params}&key=AIzaSyArEAwaJhE_ddpFBMeIwCSdHHbZUq7yaeU"))
		get_details(JSON.parse(response.body))
	end

	def get_details(hash)
		results_array = []
		hash['results'].each do |result|
			puts result['place_id']
			response = HTTParty.get(URI.encode("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{result['place_id']}&key=AIzaSyArEAwaJhE_ddpFBMeIwCSdHHbZUq7yaeU"))
			results_array << JSON.parse(response.body)
		end
		results_array
	end
end