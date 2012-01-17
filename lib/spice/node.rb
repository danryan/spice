require 'spice/persistence'

module Spice
  class Node
    include Toy::Store
    include Spice::Persistence
    extend Spice::Persistence
    store :memory, {}
    endpoint "nodes"
    
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
    
    def new_record?
      begin
        connection.get("/nodes/#{name}")
        return false
      rescue Spice::NotFound
        return true
      end
    end
  end
end