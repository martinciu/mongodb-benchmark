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
  
  desc "Wyszkiwanie"
  task :products_find do
    number_of_products = Product.count - 1
    RBench.run(1) do
      format :width => 80
      column :times
      column :one, :title => "[s]"
      [1, 10, 100, 1_000].each do |times|
        report "Wyszukiwanie produktow", times do
          one do
            begin
              Product.find(rand(number_of_products)+1)
            rescue
            end
          end
        end
      end
    end
  end
  
  desc "Lista produktow konta"
  task :account_products do
    RBench.run(1) do
      format :width => 80
      column :times
      column :one, :title => "[s]"
      [1, 10, 100, 1_000].each do |times|
        report "Lista produktow konta", times do
          one { Product.find_by_account_id(rand(SETTINGS["number_of_accounts"]))}
        end
      end
    end
  end
  
  desc "Lista produktow konta z rodzicami"
  task :account_products_with_parents do
    RBench.run(1) do
      format :width => 80
      column :times
      column :one, :title => "[s]"
      [1, 10, 100, 1_000].each do |times|
        report "Lista produktow konta z rodzicami", times do
          one { Product.find_by_account_id_with_parents(rand(SETTINGS["number_of_accounts"]))}
        end
      end
    end
  end

  desc "Update ceny"
  task :products_update do
    number_of_products = Product.count - 1
    RBench.run(1) do
      format :width => 80
      column :times
      column :one, :title => "[s]"
      [1, 10, 100, 1_000].each do |times|
        report "Update produktow", times do
          one do
            begin
              product = Product.find(rand(number_of_products)+1)
              product.price = rand(10000)/100.0
              product.save
            rescue
            end
          end
        end
      end
    end
  end
  
  desc "Usuwanie"
  task :products_delete do
    number_of_products = Product.count - 1
    RBench.run(1) do
      format :width => 80
      column :times
      column :one, :title => "[s]"
      [1, 10, 100, 1_000].each do |times|
        report "Usuwanie produktow", times do
          one do
            begin
              Product.find(rand(number_of_products)+1).destroy
            rescue
            end
          end
        end
      end
    end
  end
  
  desc "Usuniecie konta"
  task :accounts_delete do
    number_of_accounts = Account.count - 1
    RBench.run(1) do
      format :width => 80
      column :times
      column :one, :title => "[s]"
      [1, 10, 100, 1_000].each do |times|
        report "Usuwanie kont", times do
          one do
            begin
              Account.find(rand(number_of_accounts)+1).destroy
            rescue
            end
          end
        end
      end
    end
  end
  
  desc "Wszystkie benchamrki"
  task :all => [:products_find, :account_products, :account_products_with_parents, :products_update, :products_delete, :accounts_delete]

end

task :default => ["benchmark:all"]
