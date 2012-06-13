require 'faraday'
require 'spice/response/parse_json'
require 'spice/response/client_error'
require 'spice/version'

module Spice
  module Config

    # The default Chef server URL
    DEFAULT_SERVER_URL = "http://localhost:4000"
    
    # The default Chef version (changing this will enable disable certain features)
    DEFAULT_CHEF_VERSION = "0.10.10"
    
    # The default Spice User-Agent header
    DEFAULT_USER_AGENT = "Spice #{Spice::VERSION}"
    
    # Default connection options
    DEFAULT_CONNECTION_OPTIONS = {}
    
    # Default client name
    DEFAULT_CLIENT_NAME = ""
    
    # Default key file
    DEFAULT_CLIENT_KEY = ""
    
    # An array of valid config options
    
    VALID_OPTIONS_KEYS = [
      :server_url,
      :client_name,
      :client_key,
      :chef_version,
      :user_agent,
      :connection_options,
      :middleware
    ]
    
    # Default middleware stack
    DEFAULT_MIDDLEWARE = Proc.new do |builder|
      builder.use Spice::Response::ParseJSON
      builder.use Spice::Response::ClientError
      builder.adapter Faraday.default_adapter
    end
    
    VALID_OPTIONS_KEYS.each do |key|
      attr_accessor key
    end
    
    # Reset all config options to default when the module is extended
    def self.extended(base)
      base.reset
    end # def self.extended
    
    # Convenience method to configure Spice in a block
    # @example Configuring spice
    #   Spice.setup do |s|
    #     s.server_url  = "http://chef.example.com:4000"
    #     s.client_name = "admin"
    #     s.client_key    = Spice.read_key_file("/path/to/key_file.pem")
    #   end
    # @yieldparam Spice
    # @yieldreturn Spice
    def setup
      yield self
      self
    end # def setup
    
    # Create an options hash from valid options keys
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end # def options
    
    # Reset all config options to their defaults
    def reset
      self.user_agent         = DEFAULT_USER_AGENT
      self.server_url         = DEFAULT_SERVER_URL
      self.chef_version       = DEFAULT_CHEF_VERSION
      self.client_name        = DEFAULT_CLIENT_NAME
      self.client_key         = DEFAULT_CLIENT_KEY
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.middleware         = DEFAULT_MIDDLEWARE
      self
    end # def reset
    
  end # module Config
end # module Spice