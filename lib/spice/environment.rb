require 'spice/persistence'

module Spice
  class Environment
    include Toy::Store
    include Spice::Persistence
    extend Spice::Persistence
    store :memory, {}
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

  end
end