require(File.join(File.dirname(__FILE__), 'lib', 'initialize'))

namespace :db do
  desc "Prepare test data"
  task :prepare do
    SETTINGS["number_of_accounts"].times do |account_id|
      account = Account.fake(:_id => account_id)
      p account_id
      SETTINGS["products_per_account"].times do |product_id|
        product = Product.fake(:account_id => account_id)
      end
    end
  end

  desc "Clear database"
  task :clear do
    connection = MongoRecord::Base.connection
    connection.collection('products').remove()
    connection.collection('accounts').remove()
  end

  desc "Clear & prepare database"
  task :clear_and_prepare => ["clear", "prepare"]

end

namespace :benchmark do
  desc "Lista produktow konta"
  task :account_products do
    RBench.run(1) do
      format :width => 80
      column :times
      column :one, :title => "Bez rodziców"
      column :two, :title => "Z rodzicami"
      column :diff, :title => "#2/#1", :compare => [:two, :one]
      [1, 10, 100, 1_000].each do |times|
        report "Lista produktow konta", times do
          one { Product.find_by_account_id(rand(SETTINGS["number_of_accounts"]))}
          two { Product.find_by_account_id_with_parents(rand(SETTINGS["number_of_accounts"]))}
        end
      end
    end
  end

  desc "Wszystkie benchamrki"
  task :all => [:account_products]
end

task :default => ["benchmark:all"]
