require 'spice/config'
require 'spice/request'
require 'spice/authentication'
require 'spice/error'

require 'spice/core_ext/enumerable'

require 'spice/connection/search'
require 'spice/connection/clients'
require 'spice/connection/cookbooks'
require 'spice/connection/data_bags'
require 'spice/connection/environments'
require 'spice/connection/nodes'
require 'spice/connection/roles'

require 'spice/client'
require 'spice/cookbook'
require 'spice/cookbook_version'
require 'spice/data_bag'
require 'spice/data_bag_item'
require 'spice/environment'
require 'spice/node'
require 'spice/role'

module Spice
  class Connection
    include Spice::Connection::Clients
    include Spice::Connection::Cookbooks
    include Spice::Connection::DataBags
    include Spice::Connection::Environments
    include Spice::Connection::Nodes
    include Spice::Connection::Roles
    include Spice::Connection::Search
    include Spice::Request
    include Spice::Authentication
        
    attr_accessor *Config::VALID_OPTIONS_KEYS
    
    def initialize(attrs=Mash.new)
      attrs = Spice.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end # def initialize
            
    def sign_on_redirect
      @sign_on_redirect ||= true
    end # def sign_on_redirect
    
    def sign_request
      @sign_request ||= true
    end # def sign_request
    
  end # class Connection
end # module Spice