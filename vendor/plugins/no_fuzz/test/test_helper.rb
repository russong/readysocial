require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/core_ext/logger'
require 'active_record'
require 'yaml'

def load_schema
  config = YAML::load(IO.read(File.join(File.dirname(__FILE__), 'database.yml')))
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")


  ActiveRecord::Base.establish_connection(config['test'])
  load(File.dirname(__FILE__) + "/schema.rb")
  # require File.dirname(__FILE__) + '/../rails/init.rb'
end
