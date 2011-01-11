module Spice
  class Cookbook < Spice::Chef
    def self.all(options={})
      connection.get("/cookbooks")
    end
    
    def self.[](name)
      connection.get("/cookbooks/#{name}")
    end
    
    def self.show(options={})
      name = options.delete(:name)
      connection.get("/cookbooks/#{name}")
    end
    
    def self.create(options={})
      connection.post("/cookbooks", options)
    end
    
    def self.update(options={})
      name = options.delete(:name)
      connection.put("/cookbooks/#{name}", options)
    end
    
    def self.delete(options={})
      name = options.delete(:name)
      connection.delete("/cookbooks/#{name}", options)
    end
  end
end