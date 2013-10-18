require 'bundler/setup'

require 'sinatra/base'
require 'sinatra/reloader'

require 'json'
require 'mongo'

load 'snowball.rb'

class Snowput < Sinatra::Base

	configure do
		register Sinatra::Reloader
		also_reload 'snowball.rb'
	end

	before do

		response.headers['Access-Control-Allow-Origin'] = '*'

		if request.request_method == 'OPTIONS'		
			response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Content-Type, X-Snowput-Auth'
			response.headers['Access-Control-Allow-Methods'] = 'GET,POST,PUT,DELETE'
			halt 200
		end

		if request.env['HTTP_X_SNOWPUT_AUTH'] != "_dev"
			halt 403, [].snowball(nil,
				"INVALID_HTTP_X_SNOWPUTH_AUTH"
			)
		end

		s = Snowball.new(request.env['HTTP_X_SNOWPUT_AUTH'])
		@db = s.roll()

		params = request.path.split("/")
		# params[1]
		# params[2]
		method = request.request_method

		puts "\tTaking in a " + method
		puts "\tCheking params..."
		puts "\tParam 1 [" + params[1].to_s+"]"
		puts "\tParam 2 [" + params[2].to_s+"]"

		puts "==== Checking headers ... ===="
		puts "\nHTTP_SNOWPUT_AUTH: " + request.env['HTTP_SNOWPUT_AUTH']

		puts "\n[Ready to roll]\n\n"

	end

	get '/:snow/?:sub?' do
		halt 200, @db.collection(params[:snow]).find().to_a.snowball("GET")
	end

	post '/:snow/?:sub?' do
		push = JSON.parse(request.body.read)
		insert = @db.collection(params[:snow]).insert(push)
		if !insert.nil?
			halt 200, push.snowball("POST")
		end
	end

	get '/' do
		"<code>Welcome to Snowput.</code>"
	end

	run!
end
	