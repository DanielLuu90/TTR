namespace :mst do
	task fetch_data: :environment do
		arr = "0123456789".split('')
		prefix = ENV['PREFIX']
		num = ENV['NUMBER'].to_i
		max = (ENV['MAX'] || ''.rjust(num, '9')).to_i
		min = (ENV['MIN'] || 0).to_i
		code = ENV['CODE']
		number = min
		while number <= max do
			t = Time.now
			cmnd = "#{prefix}#{number.to_s.rjust(num, '0')}"
			printf "#{cmnd}\t"
			data = Mst.fetch_data(cmnd: cmnd, code: code)
			printf "#{Time.now - t}\t"
			printf "==>#{data[:data].ten}" if data[:data]
			printf "==>#{data[:message]}" if data[:error]	
			printf "\n"
			break unless data
			number += 1
		end
	end
end