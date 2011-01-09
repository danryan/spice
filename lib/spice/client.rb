module Spice
  class Client < Spice::Chef
    attr_accessor :name, :public_key

    def initialize(options={})
      @name = options[:name]
      @public_key = options[:public_key]
      @admin = options[:admin] || false
      @chef_type = options[:client] || "Chef::ApiClient"
      @_rev = options[:rev] || ""
    end
    
    def self.all
      connection.get("/clients").map { |c| c[0] }
    end
    
    def self.[](name)
      connection.get("/clients/#{name}")
    end
    
    def self.find(options={})
      name = options.delete(:name)
      connection.get("/clients/#{name}")
      # Client.new(
      #   :name => client[:name], 
      #   :public_key => client[:public_key],
      #   :admin => client[:admin],
      #   :chef_type => client[:chef_type],
      #   :_rev => client[:rev]
      # )
    end
    
    def self.create(options={})
      connection.post("/clients", options)
    end
    
    def self.update(options={})
      name = options.delete(:name)
      connection.put("/clients/#{name}", options)
    end
    
    def self.delete(options={})
      name = options[:name]
      connection.delete("/clients/#{name}")
    end
  end
end