$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bundler'
Bundler.require

require 'rspec'
require 'webmock/rspec'
require 'timecop'
require 'forgery'
require 'spice'
require 'chef'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before do
    Timecop.freeze
  end
  config.after do
    Timecop.return
  end
end
