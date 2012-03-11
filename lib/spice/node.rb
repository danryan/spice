require 'spice/persistence'

module Spice
  class Node
    include Virtus
    include Aequitas
    include Spice::Persistence
    extend Spice::Persistence

    endpoint "nodes"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, String
    attribute :chef_type, String, :default => "node"
    attribute :json_class, String, :default => "Chef::Node"
    attribute :normal, Hash, :default => {}
    attribute :override, Hash, :default => {}
    attribute :default, Hash, :default => {}
    attribute :automatic, Hash, :default => {}
    attribute :run_list, Array, :default => []
        
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