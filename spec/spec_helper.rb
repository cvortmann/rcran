require 'mongoid'
require 'database_cleaner'
require 'celluloid'
require 'logger'

ENV['RACK_ENV'] = 'test'

Mongoid.load!("config/mongoid.yml")

Dir.mkdir("log") unless Dir.exists?("log")
Celluloid.logger = ::Logger.new("log/celluloid.test.log")

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
    Celluloid.shutdown
    Celluloid.boot
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
