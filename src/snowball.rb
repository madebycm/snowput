include Mongo

class Snowball
	def roll(host="localhost", port=27017)
		@mongo_client = MongoClient.new(host, port)
		@db = @mongo_client.db("snowput")
		return @db
	end
end

class Array
	def snowball(method=nil)
		jsonObj = {
			"method" => (method==nil ? "(not provided)" : method),
			"results" => self.length,
			"auth" => nil,
				"d" => self,
			"time" => Time.now,
			"signature" => SecureRandom.uuid,
		}
		return jsonObj.to_json
	end
end

class Hash
	def snowball(method=nil)
		return pack(self,method)
	end
end

def pack(data,method=nil)
	jsonObj = {
		"method" => (method==nil ? "(not provided)" : method),
		"results" => data.length,
		"auth" => nil,
			"d" => data,
		"time" => Time.now,
		"signature" => SecureRandom.uuid,
	}
	return jsonObj.to_json
end