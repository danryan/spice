module Spice
  class DataBag < Spice::Chef
    def self.all(options={})
      return connection.get("/data")
    end
    
    def self.[](name)
      connection.get("/data/#{name}")
    end
    
    def self.show(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.get("/data/#{name}")
    end
    
    def self.create(options={})
      connection.post("/data", options)
    end
    
    def self.update(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.put("/data/#{name}", options)
    end
    
    def self.delete(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.delete("/data/#{name}", options)
    end
  end
end