module Spice
  class Client < Spice::Chef    
    def self.all(options={})
      if options[:complete]
        results = []
        connection.get("/clients").map { |c| c[0] }.each do |client|
          results << connection.get("/clients/#{client}")
        end
        results
      else
        connection.get("/clients")
      end
    end
    
    def self.[](name)
      connection.get("/clients/#{name}")
    end
    
    def self.show(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.get("/clients/#{name}")
    end
    
    def self.create(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      connection.post("/clients", options)
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