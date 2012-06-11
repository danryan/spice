require 'spice/persistence'

module Spice
  class Client
    include ActiveAttr::Model
    include Spice::Persistence
    extend Spice::Persistence
    
    endpoint "clients"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, :type => String
    attribute :public_key, :type => String
    attribute :private_key, :type => String
    attribute :_rev, :type => String
    attribute :json_class, :type => String, :default => "Chef::ApiClient"
    attribute :admin, :type => Boolean, :default => false
    attribute :chef_type, :type => String, :default => "client"
    
    validates_presence_of :name, :json_class, :chef_type

    def do_post
      response = connection.post("/clients", :name => name)
      update_attributes(response.body)
      response = connection.get("/clients/#{name}")
      update_attributes(response.body)
    end
    
    def do_put
      response = connection.put("/clients/#{name}", attributes)
    end

    def self.get(name)
      connection.client(name)
    end
    
    # Check if the client exists on the Chef server
    def new_record?
      begin
        connection.get("/clients/#{name}")
        return false
      rescue Spice::Error::NotFound
        return true
      end
    end
  end
end