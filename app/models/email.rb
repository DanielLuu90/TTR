class Email < ActiveRecord::Base
	class << self
		def check_valid(email: "")
			url = 'https://accounts.google.com/InputValidator?resource=SignUp&service=mail' 
			uri = URI.parse(url)
			headers = {
	      'Referer' 		=> 'https://accounts.google.com/SignUp?service=mail&continue=http%3A%2F%2Fmail.google.com%2Fmail%2F%3Fpc%3Dtopnav-about-vi',
	      'Origin'  		=> 'https://accounts.google.com',
	      'User-Agent'	=> 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36',
	      'Content-type'=> 'application/json'
			}		
			data = {
				"input01" => {
					"Input" => "GmailAddress",
					"GmailAddress" => email,
					"FirstName" => "",
					"LastName" => ""
				},
				"Locale" => "vi"
			} 
			http = Net::HTTP.new uri.host, uri.port
			http.use_ssl = true
  		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			response = http.post uri.path, data.to_json, headers
			if response.body 
				res = JSON.parse(response.body).to_h
				res["input01"]["Valid"] == "true"
			else
				false
			end
		end
	end
end
