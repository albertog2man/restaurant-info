class Search

	def by(intent,options)
		params = ""
		options.each do |v,k|
            params += "#{v}=#{k}&"
        end
        response = HTTParty.get(URI.encode("https://api.foursquare.com/v2/venues/explore?intent=#{intent}&#{params}client_id=DGYOAJXYGFIC5Y44Z5JA5HEU10CXPDF0UKQEZQA4JMPIOVDZ&client_secret=SD1WOKW14QOLFF1PWHJ2HGE3DDZS1OW40HRULDCOXAGXDFGE&v=20140806"))
        # puts response.body
        JSON.parse(response.body)
	end
end