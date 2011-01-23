module Spice
  class Cookbook < Spice::Chef
    def self.all(options={})
      connection.get("/cookbooks")
    end
    
    def self.[](name)
      connection.get("/cookbooks/#{name}")
    end
    
    def self.show(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.get("/cookbooks/#{name}")
    end
    
    def self.create(options={})
      connection.post("/cookbooks", options)
    end
    
    def self.update(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.put("/cookbooks/#{name}", options)
    end
    
    def self.delete(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.delete("/cookbooks/#{name}", options)
    end
  end
end