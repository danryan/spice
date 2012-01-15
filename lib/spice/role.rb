module Spice
  class Role
    include Toy::Store
    store :memory, {}
    
    attribute :name, String
    attribute :description, String
    attribute :run_list, Array, :default => []
    attribute :default_attributes, Hash, :default => {}
    attribute :override_attributes, Hash, :default => {}
    attribute :json_class, String, :default => "Chef::Role"
    attribute :chef_type, String, :default => "role"

    validates_presence_of :name, :description
    
    def self.all(options={})
      connection.get("/roles")
    end
    
    def self.[](name)
      connection.get("/roles/#{name}")
    end
    
    def self.show(options={})
      name = options.delete(:name)
      connection.get("/roles/#{name}")
    end
    
    def self.create(options={})
      connection.post("/roles", options)
    end
    
    def self.update(options={})
      name = options.delete(:name)
      connection.put("/roles/#{name}", options)
    end
    
    def self.delete(options={})
      name = options.delete(:name)
      connection.delete("/roles/#{name}", options)
    end
  end
end