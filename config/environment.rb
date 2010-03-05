RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

# prevent deprecated method message
if Gem::VERSION >= "1.3.6"
  module Rails
    class GemDependency
      def requirement
        r = super
        (r == Gem::Requirement.default) ? nil : r
      end
    end
  end
end

Rails::Initializer.run do |config|
  config.load_paths << "#{RAILS_ROOT}/app/sweepers"
  config.time_zone = 'UTC'
  
  # config.gem "authlogic"
  # config.gem "declarative_authorization", :source => "http://gemcutter.org"
  # config.gem "acts-as-taggable-on"

  config.gem "haml"
  config.gem "devise"
  config.gem "warden"
  config.gem "will_paginate"

  # config.gem "inherited_resources", :version => "1.0.4"
  # config.gem "RedCloth"
end


### Fix in memory database for tests
# Update: Looks for the SQLite and SQLite3 adapters for
# compatibility with Rails 1.2.2 and also older versions.
def in_memory_database?
  if ENV["RAILS_ENV"] == "test" and
    (Rails::Configuration.new.database_configuration['test']['database'] == ':memory:' or
    Rails::Configuration.new.database_configuration['test']['dbfile'] == ':memory:')
    begin
      if ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLite3Adapter
        return true
      end
    rescue NameError => e
      if ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLiteAdapter
        return true
      end
    end
  end
  false
end

def verbosity
  Rails::Configuration.new.database_configuration['test']['verbosity']
end

def inform_using_in_memory
  puts "Creating sqlite :memory: database"
end

if in_memory_database?
  load_schema = lambda {
    load "#{RAILS_ROOT}/db/schema.rb" # use db agnostic schema by default
    #  ActiveRecord::Migrator.up('db/migrate') # use migrations
  }
  case verbosity
  when "silent"
    silence_stream(STDOUT, &load_schema)
  when "quiet"
    inform_using_in_memory
    silence_stream(STDOUT, &load_schema)
  else
    inform_using_in_memory
    load_schema.call
  end
end
