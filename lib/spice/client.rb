require 'spice/persistence'

module Spice
  class Client
    include Toy::Store
    include Spice::Persistence
    extend Spice::Persistence
    store :memory, {}
    endpoint "roles"
    
    attribute :name, String
    attribute :public_key, String
    attribute :private_key, String
    attribute :_rev, String
    attribute :json_class, String, :default => "Chef::ApiClient"
    attribute :admin, Boolean, :default => false
    attribute :chef_type, String, :default => "client"
    
    validates_presence_of :name, :json_class, :chef_type

  end
end