require 'active_attr'
# require 'active_model/callbacks'
require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/hash/keys'
require 'mixlib/authentication'

require 'spice/config'
require 'spice/error'
require 'spice/authentication'

require 'spice/role'
require 'spice/client'
require 'spice/cookbook'
require 'spice/cookbook_version'
require 'spice/data_bag'
require 'spice/data_bag_item'
require 'spice/node'
require 'spice/environment'
require 'spice/connection'

require 'spice/connection/clients'
require 'spice/connection/cookbooks'
require 'spice/connection/data_bags'
require 'spice/connection/environments'
require 'spice/connection/nodes'
require 'spice/connection/roles'
require 'spice/connection/search'

require 'spice/version'
require 'spice/mock'

module Spice
  extend Config
  extend self
  
  extend Spice::Connection::Clients
  extend Spice::Connection::Cookbooks
  extend Spice::Connection::DataBags
  extend Spice::Connection::Environments
  extend Spice::Connection::Nodes
  extend Spice::Connection::Roles
  extend Spice::Connection::Search
    
  def connection
    Connection.new(
      :server_url => server_url,
      :client_name => client_name,
      :key_file => key_file
    )
  end

  def mock
    Spice::Mock.setup_mock_client
  end
end
