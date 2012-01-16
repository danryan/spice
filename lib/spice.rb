require 'toystore'
require 'adapter/memory'
require 'mixlib/authentication'

require 'spice/config'
require 'spice/error'
require 'spice/authentication'
require 'spice/chef'

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
    @connection ||= Connection.new(
      :server_url => server_url,
      :client_name => client_name,
      :key_file => key_file
    )
  end

  def mock
    Spice::Mock.setup_mock_client
  end

  # def autoconfigure!(path=nil)
  #   path ||= "~/.chef/"
  #   knife = File.exist?("~/.chef/knife.rb") && File.expand_path(path + "~/.chef/knife.rb")
  #   client = File.exist?("/etc/chef/client.rb") && File.expand_path("/etc/chef/client.rb")
  #   
  #   if knife
  #     raw_config = IO.read(knife)
  #   elsif
  #     raw_config = IO.read(client)
  #   end
  #   
  #   @values = {}
  #   raw_config.each_line do |line|
  #     if line =~ /^chef_server_url.*/
  #       @values[:chef_server_url] = parse_line(line)
  #     elsif line =~ /^node_name.*/
  #       @values[:node_name] = parse_line(line)
  #     elsif line =~ /^client_key.*/
  #       @values[:client_key] = parse_line(line)
  #     end
  #   end
  # end
    

end
