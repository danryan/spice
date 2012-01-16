require 'spice/version'

module Spice
  module Config
    DEFAULT_SERVER_URL = "http://localhost:4000"
    
    DEFAULT_CHEF_VERSION = "0.10.4"
        
    DEFAULT_USER_AGENT = "Spice #{Spice::VERSION}"
    
    DEFAULT_CONNECTION_OPTIONS = {}
    
    VALID_OPTIONS_KEYS = [
      :server_url,
      :client_name,
      :key_file,
      :raw_key,
      :chef_version,
      :adapter,
      :user_agent,
      :connection_options
    ]
    
    attr_accessor *VALID_OPTIONS_KEYS
    
    def self.extended(base)
      base.reset
    end
    
    def setup
      yield self
      self
    end
    
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end
    
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