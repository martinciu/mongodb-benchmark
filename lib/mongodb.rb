class MongoTest
  include Mongo
  
  def initialize
    @coll = Connection.new('localhost').db('mongodb-benchamrk').collection('test')
  end
  
  def purge
    @coll.remove
  end
  
  def inserts(limit = 1000)
    limit.times {
      @coll.insert(
        :name        => Faker::Lorem.words,
        :description => Faker::Lorem.paragraphs
      )
    }
  end
  
  def select
    
  end

end

  
  

