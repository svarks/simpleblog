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

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[:default] = "%B %d, %Y %H:%M"
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:default] = '%m/%d/%Y'
