module Spice
  class Node < Spice::Chef
    def self.all(options={})
      connection.get("/nodes")
    end
    
    def self.[](name)
      connection.get("/nodes/#{name}")
    end
    
    def self.show(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.get("/nodes/#{name}")
    end
    
    def self.create(options={})
      connection.post("/nodes", options)
    end
    
    def self.update(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.put("/nodes/#{name}", options)
    end
    
    def self.delete(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.delete("/nodes/#{name}", options)
    end
  end
end