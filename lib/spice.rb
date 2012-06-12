require 'spice/core_ext/mash'

require 'spice/config'
require 'spice/connection'

require 'spice/mock'

module Spice
  extend Spice::Config
  
  class << self
    # Convience alias for Spice::Connection.new
    #
    # return [Spice::Connection]
    def new(options=Mash.new)
      Spice::Connection.new(options)
    end # def new
    
    # Delegate methods to Spice::Connection
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end # def method_missing
    
    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end # def respond_to?
    
    def mock
      Spice::Mock.setup_mock_client
    end # def mock
  end
end

