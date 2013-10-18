class Snowput < Sinatra::Base

	configure do
		register Sinatra::Reloader
		also_reload 'snowball.rb', 'operations.rb'
	end

	before do

		response.headers['Access-Control-Allow-Origin'] = '*'

		if request.request_method == 'OPTIONS'		
			response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Content-Type, X-Snowput-Auth'
			response.headers['Access-Control-Allow-Methods'] = 'GET,POST,PUT,DELETE'
			halt 200
		end

		unless request.env['HTTP_X_SNOWPUT_AUTH'] == "_dev"
			halt 403, [].snowball(nil,
				"INVALID_HTTP_X_SNOWPUT_AUTH"
			)
		end

		snowput_auth = request.env['HTTP_X_SNOWPUT_AUTH']

		s = Snowball.new(snowput_auth)
		@db = s.roll()

		params = request.path.split("/")
		method = request.request_method

		puts "\tTaking in a " + method
		puts "\tCheking params..."
		puts "\tParam 1 [" + params[1].to_s+"]"
		puts "\tParam 2 [" + params[2].to_s+"]"

		puts "==== Checking headers ... ===="
		puts "\nHTTP_SNOWPUT_AUTH: " + snowput_auth.to_s

		puts "\n[Ready to roll]\n\n"

	end

end