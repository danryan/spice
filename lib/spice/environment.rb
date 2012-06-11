require 'spice/persistence'

module Spice
  class Environment
    include ActiveAttr::Model
    include Spice::Persistence
    extend Spice::Persistence

    endpoint "environments"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, :type => String
    attribute :description, :type => String
    attribute :attrs, :type => Hash, :default => {}
    attribute :json_class, :type => String, :default => "Chef::Environment"
    attribute :chef_type, :type => String, :default => "environment"
    attribute :cookbook_versions, :type => Hash, :default => {}
    
    validates_presence_of :name, :description

    # Check if the environment exists on the Chef server
    def new_record?
      connection.get("/environments/#{name}")
      return false
    rescue Spice::Error::NotFound
      return true
    end
  end
end