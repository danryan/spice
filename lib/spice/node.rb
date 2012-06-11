require 'spice/persistence'

module Spice
  class Node
    include ActiveAttr::Model
    include Spice::Persistence
    extend Spice::Persistence

    endpoint "nodes"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, :type => String
    attribute :chef_type, :type => String, :default => "node"
    attribute :json_class, :type => String, :default => "Chef::Node"
    attribute :normal, :type => Hash, :default => {}
    attribute :override, :type => Hash, :default => {}
    attribute :default, :type => Hash, :default => {}
    attribute :automatic, :type => Hash, :default => {}
    attribute :run_list, :type => Array, :default => []
        
    validates_presence_of :name

    def self.get(name)
      connection.node(name)
    end
    
    # Check if the node exists on the Chef server
    def new_record?
      begin
        connection.get("/nodes/#{name}")
        return false
      rescue Spice::Error::NotFound
        return true
      end
    end
  end
end