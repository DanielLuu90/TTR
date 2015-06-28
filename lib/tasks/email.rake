namespace :email do
	desc "利用状況をgoogle spreadsheetに追記"
	task gen: :environment do
		arr = "1234567890".split('')
		base = "trami"
		arr.each do |a|
			arr.each do |b|
				arr.each do |c|
					arr.each do |d|
						email = "#{base}#{a}#{b}#{c}#{d}"
						result = !Email.check_valid(email: email)
						if result
							Email.create email: email
						end
						puts "#{email}\t=>\t#{result}"
					end
				end
			end
		end			
	end
end