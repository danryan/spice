require 'spice/persistence'

module Spice
  class Role
    include ActiveAttr::Model

    include Spice::Persistence
    extend Spice::Persistence
    
    endpoint "roles"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, :type => String
    attribute :description, :type => String
    attribute :run_list, :type => Array, :default => []
    attribute :default_attributes, :type => Hash, :default => {}
    attribute :override_attributes, :type => Hash, :default => {}
    attribute :json_class, :type => String, :default => "Chef::Role"
    attribute :chef_type, :type => String, :default => "role"

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