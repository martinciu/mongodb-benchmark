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

task :default => ["db:clear_and_prepare"]

