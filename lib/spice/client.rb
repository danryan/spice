require 'spice/persistence'

module Spice
  class Client
    include Virtus
    include Aequitas
    include Spice::Persistence
    extend Spice::Persistence
    
    endpoint "clients"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, String
    attribute :public_key, String
    attribute :private_key, String
    attribute :_rev, String
    attribute :json_class, String, :default => "Chef::ApiClient"
    attribute :admin, Boolean, :default => false
    attribute :chef_type, String, :default => "client"
    
    validates_presence_of :name, :json_class, :chef_type

    after_create :wat
    def wat
      puts "WAT"
    end
    
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