module Spice
  class DataBag < Spice::Chef
    def self.list(options={})
      connection.get("/data")
    end
    
    def self.[](name)
      connection.get("/data/#{name}")
    end
    
    def self.show(options={})
      name = options.delete(:name)
      connection.get("/data/#{name}")
    end
    
    def self.create(options={})
      connection.post("/data", options)
    end
    
    def self.update(options={})
      name = options.delete(:name)
      connection.put("/data/#{name}", options)
    end
    
    def self.delete(options={})
      name = options.delete(:name)
      connection.delete("/data/#{name}", options)
    end
  end
end