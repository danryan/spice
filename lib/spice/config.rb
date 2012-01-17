require 'spice/version'

module Spice
  module Config
    # The default Chef server URL
    DEFAULT_SERVER_URL = "http://localhost:4000"
    
    # The default Chef version (changing this will enable disable certain features)
    DEFAULT_CHEF_VERSION = "0.10.8"
    
    # The default Spice User-Agent header
    DEFAULT_USER_AGENT = "Spice #{Spice::VERSION}"
    
    # Default connection options
    DEFAULT_CONNECTION_OPTIONS = {}
    
    # An array of valid config options
    VALID_OPTIONS_KEYS = [
      :server_url,
      :client_name,
      :key_file,
      :raw_key,
      :chef_version,
      :user_agent,
      :connection_options
    ]
    
    VALID_OPTIONS_KEYS.each do |key|
      attr_accessor key
    end
    
    # Reset all config options to default when the module is extended
    def self.extended(base)
      base.reset
    end
    
    # Convenience method to configure Spice in a block
    # @example Configuring spice
    #   Spice.setup do |s|
    #     s.server_url  = "http://chef.example.com:4000"
    #     s.client_name = "admin"
    #     s.key_file    = "/home/admin/.chef/admin.pem"
    #   end
    # @yieldparam Spice
    # @yieldreturn Spice    
    
    def setup
      yield self
      self
    end
    
    # Create an options hash from valid options keys
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end
    
    # Reset all config options to their defaults
    def reset
      self.user_agent = DEFAULT_USER_AGENT
      self.server_url = DEFAULT_SERVER_URL
      self.chef_version = DEFAULT_CHEF_VERSION
      self.client_name = nil
      self.key_file = nil
      self.raw_key = nil
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
    end
    
  end
end