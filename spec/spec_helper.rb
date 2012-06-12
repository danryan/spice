require 'rubygems'
require 'spork'

Spork.prefork do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
  $LOAD_PATH.unshift(File.dirname(__FILE__))
  require 'bundler'
  Bundler.require

  require 'rspec'
  require 'webmock/rspec'
  require 'timecop'
  require 'fakefs'
  require 'fileutils'
  require 'vcr'
  
  require 'spice'
  
  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.

  RSpec.configure do |config|
    config.before do
      Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
      
      Timecop.freeze
      # Spice.mock
      FakeFS.activate!
    end
    config.after do
      Timecop.return
      FakeFS.deactivate!
    end
  end
end

Spork.each_run do
  require 'spice'
  # This code will be run each time you run your specs.
end