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
			response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With'
			response.headers['Access-Control-Allow-Methods'] = 'GET,POST,PUT,DELETE'
			halt 200
		end

		params = request.path.split("/")
		# params[1]
		# params[2]
		method = request.request_method

		puts "\tTaking in a " + method
		puts "\tCheking params..."
		puts "\tParam 1 [" + params[1].to_s+"]"
		puts "\tParam 2 [" + params[2].to_s+"]"
		puts "\tReady for action.\n\n"

	end

	s = Snowball.new
	db = s.roll()

	get '/:snow/?:sub?' do
		"#{db.collection(params[:snow]).find().to_a.snowball}"
	end

	post '/:snow/?:sub?' do
		push = {
			"test" => "jajaja"
		}
		insert = db.collection(params[:snow]).insert(push)
		"#{insert}"
	end

	get '/' do
		"<code>Welcome to Snowput.</code>"
	end

	run!
end
	