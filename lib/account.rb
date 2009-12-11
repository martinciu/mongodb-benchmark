class Account < MongoRecord::Base
    collection_name :accounts
    fields :name
    
    def self.fake(attributes = {})
      self.create({:name => Faker::Name.name}.merge(attributes))
    end

end