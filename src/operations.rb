class Operations < Snowput 

	get '/:snow/?:sub?' do
		halt 200, @db.collection(params[:snow]).find().to_a.snowball("GET")
	end

	post '/:snow/?:sub?' do
		push = JSON.parse(request.body.read)
		insert = @db.collection(params[:snow]).insert(push)
		if !insert.nil?
			halt 200, push.snowball(@method)
		end
	end

	get '/' do
		"<code>Welcome to Snowput.</code>"
	end

	run!
end