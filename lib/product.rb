class Product < MongoRecord::Base
    collection_name :products
    fields :name, :price, :description, :active, :stock_level, :short_description, :account_id, :parent_id
    
    def self.fake(attributes = {})
      product = Product.create({
        :name              => Faker::Lorem.words(5).join(" "), 
        :price             => rand(10000)/100.0,
        :description       => Faker::Lorem.paragraphs(5).join(" "),
        :active            => [true, false].rand, 
        :stock_level       => rand(1000), 
        :short_description => Faker::Lorem.sentence,
        :account_id        => rand(SETTINGS["number_of_accounts"])
      }.merge(attributes))
      while rand < SETTINGS["inheritance_ratio"]
        Product.fake(:parent_id => product._id)
      end
      return product
    end
    
end