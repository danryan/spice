require 'spice/persistence'

module Spice
  class Environment
    include Virtus
    include Aequitas
    include Spice::Persistence
    extend Spice::Persistence

    endpoint "environments"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, String
    attribute :description, String
    attribute :attrs, Hash, :default => {}
    attribute :json_class, String, :default => "Chef::Environment"
    attribute :chef_type, String, :default => "environment"
    attribute :cookbook_versions, Hash, :default => {}
    
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