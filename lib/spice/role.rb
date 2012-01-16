require 'spice/persistence'

module Spice
  class Role
    include Toy::Store
    include Spice::Persistence
    extend Spice::Persistence
    
    store :memory, {}
    endpoint "roles"
    
    attribute :name, String
    attribute :description, String
    attribute :run_list, Array, :default => []
    attribute :default_attributes, Hash, :default => {}
    attribute :override_attributes, Hash, :default => {}
    attribute :json_class, String, :default => "Chef::Role"
    attribute :chef_type, String, :default => "role"

    validates_presence_of :name, :description

  end
end