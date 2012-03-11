require 'spice/persistence'

module Spice
  class Role
    include Virtus
    include Aequitas
    include Spice::Persistence
    extend Spice::Persistence
    
    endpoint "roles"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, String
    attribute :description, String
    attribute :run_list, Array, :default => []
    attribute :default_attributes, Hash, :default => {}
    attribute :override_attributes, Hash, :default => {}
    attribute :json_class, String, :default => "Chef::Role"
    attribute :chef_type, String, :default => "role"

    validates_presence_of :name, :description
    
    def self.get(name)
      connection.role(name)
    end
    
    # Check if the role exists on the Chef server
    def new_record?
      begin
        connection.get("/roles/#{name}")
        return false
      rescue Spice::Error::NotFound
        return true
      end
    end
  end
end