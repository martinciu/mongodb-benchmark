require 'rubygems'
require 'faker'
require 'mongo'
require 'mongo_record'
require 'rbench'

DB_CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), "../config/database.yml" ))
SETTINGS = YAML.load_file(File.join(File.dirname(__FILE__), "../config/settings.yml"))["small"]

MongoRecord::Base.connection = Mongo::Connection.new.db(DB_CONFIG["database"])

require(File.join(File.dirname(__FILE__), 'product'))
require(File.join(File.dirname(__FILE__), 'account'))

