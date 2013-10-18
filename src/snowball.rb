include Mongo

class Snowball

	def initialize(auth)
		$auth = auth
	end

	def roll(host="localhost", port=27017)
		mongo_client = MongoClient.new(host, port)
		db = mongo_client.db("snowput")
		return db
	end
end

class Array
	def snowball(method, auth=$auth)
		jsonObj = {
			"method" => (method==nil ? "(not provided)" : method),
			"results" => self.length,
			"auth" => auth,
				"d" => self,
			"time" => Time.now,
			"signature" => SecureRandom.uuid,
		}
		$auth = nil
		return jsonObj.to_json
	end
end

class Hash
	def snowball(method=nil, auth=$auth)
		return pack(self,method)
	end
end

def pack(data,method=nil, auth=$auth)
	jsonObj = {
		"method" => (method==nil ? "(not provided)" : method),
		"results" => data.length,
		"auth" => auth,
			"d" => data,
		"time" => Time.now,
		"signature" => SecureRandom.uuid,
	}
	$auth = nil
	return jsonObj.to_json
end