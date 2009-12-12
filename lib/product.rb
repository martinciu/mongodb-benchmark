class Product < MongoRecord::Base
    collection_name :products
    fields :name, :price, :description, :active, :stock_level, :short_description, :account_id, :parent_ids, :_id
    attr_accessor :parents
    
    index :account_id
    
    @@id_counter = 1
    
    def self.fake(attributes = {})
      product = Product.create({
        :_id               => @@id_counter,
        :name              => Faker::Lorem.words(5).join(" "), 
        :price             => rand(10000)/100.0,
        :description       => Faker::Lorem.paragraphs(5).join(" "),
        :active            => [true, false].rand, 
        :stock_level       => rand(1000), 
        :short_description => Faker::Lorem.sentence,
        :account_id        => rand(SETTINGS["number_of_accounts"]),
        :parent_ids        => []
      }.merge(attributes))
      @@id_counter += 1
      while rand < SETTINGS["inheritance_ratio"]
        Product.fake(:parent_ids => product.parent_ids + [product._id])
      end
      return product
    end
    
    def self.find_by_account_id_with_parents(account_id)
      Product.find_all_by_account_id(account_id).map {|p| p.parents = Product.find(:all, :comditions => ["_id IN (?)", p.parent_ids])}
    end
    
end