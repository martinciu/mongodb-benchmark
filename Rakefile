require(File.join(File.dirname(__FILE__), 'lib', 'initialize'))

namespace :mongodb do
  desc "Mongodb - inserts"
  task :inserts do
    RBench.run(1) do

      column :n_1000,    :title => "1,000"
      column :n_10000,   :title => "10,000"
      # column :n_100000,  :title => "100,000"
      # column :n_1000000, :title => "1,000,000"
      
      mt = MongoTest.new
      report "mongodb" do
        n_1000 {
          mt.purge
          mt.inserts(1000)
        }
        n_10000 {
          mt.purge
          mt.inserts(10000)
        }
        # n_100000 {
        #   mt.purge
        #   mt.inserts(100000)
        # }
        # n_1000000 {
        #   mt.purge
        #   mt.inserts(1000000)
        # }
      end
    end
  end
end
    
