module Spice
  class Client
    include Toy::Store
    store :memory, {}
    
    attribute :name, String
    attribute :public_key, String
    attribute :private_key, String
    attribute :_rev, String
    attribute :json_class, String, :default => "Chef::ApiClient"
    attribute :admin, Boolean, :default => false
    attribute :chef_type, String, :default => "client"

    validates_presence_of :name, :json_class, :chef_type

    def connection
      if Spice.connection
        @connection = Spice.connection
      else
        @connection = Connection.new(
          :server_url => Spice.server_url,
          :client_name => Spice.client_name,
          :key_file => Spice.key_file
        )
      end
      @connection
    end
    
    def create
      response = connection.post("/clients", attributes.except('id'))
      update_attributes(response)
    end
    
    def self.show(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.get("/clients/#{name}")
    end
    
    def self.create(options={})
      client = new(options)
      client.create
    end
    
    def self.update(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.put("/clients/#{name}", options)
    end
    
    def self.delete(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.delete("/clients/#{name}", options)
    end
  end
end