include Mongo

class Snowball
	def roll(host="localhost", port=27017)
		@mongo_client = MongoClient.new(host, port)
		@db = @mongo_client.db("snowput")
		return @db
	end
end

# extend
class Array
	def snowball
		jsonObj = {
			"results" => self.length,
			"auth" => nil,
				"d" => self,
			"time" => Time.now,
			"signature" => SecureRandom.uuid,
		}
		return jsonObj.to_json
	end
end