require 'mongoid'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'
Mongoid.load!("config/mongoid.yml")

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
