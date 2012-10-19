require 'spice/core_ext/mash'

require 'spice/config'
require 'spice/connection'

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
      Spice.server_url = 'http://localhost:4000/organizations/spice'
      Spice.client_name = "testclient"
      Spice.client_key = Spice.read_key_file(File.expand_path("../../spec/fixtures/client.pem", __FILE__))
      Spice.chef_version = "0.10.10"
      self
    end # def mock
    
    def read_key_file(path)
      key_file_path = File.expand_path(path)
      
      begin
        raw_key = File.read(key_file_path).strip
      rescue SystemCallError, IOError => e
        raise IOError, "Unable to read #{key_file_path}"
      end
      
      begin_rsa = "-----BEGIN RSA PRIVATE KEY-----"
      end_rsa   = "-----END RSA PRIVATE KEY-----"
      
      unless (raw_key =~ /\A#{begin_rsa}$/) && (raw_key =~ /^#{end_rsa}\Z/)
        msg = "The file #{key_file_path} is not a properly formatted private key.\n"
        msg << "It must contain '#{begin_rsa}' and '#{end_rsa}'"
        raise ArgumentError, msg
      end
      return OpenSSL::PKey::RSA.new(raw_key)
    end # def read_key_file
    
  end # class << self
end # module Spice

