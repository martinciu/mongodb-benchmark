class Account < MongoRecord::Base
    collection_name :accounts
    fields :name
    
    def destroy
      Product.destroy_all("account_id = #{self._id}")
      super
    end
    
    def self.fake(attributes = {})
      self.create({:name => Faker::Name.name}.merge(attributes))
    end

end