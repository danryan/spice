module Spice
  class DataBag < Spice::Chef
    # Get a list of all data bags in the following syntax
    #     
    #     
    def self.all(options={})
      connection.get("/data")
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

    def self.delete(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.delete("/data/#{name}", options)
    end
    
    def self.show_item(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      raise ArgumentError, "Option :id must be present" unless options[:id]
      name = options.delete(:name)
      id = options.delete(:id)
      connection.get("/data/#{name}/#{id}", options)
      
    end
    
    def self.create_item(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      raise ArgumentError, "Option :id must be present" unless options[:id]
      name = options.delete(:name)
      connection.post("/data/#{name}", options)   
      
    end
    
    def self.update_item(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      raise ArgumentError, "Option :id must be present" unless options[:id]  
      name = options.delete(:name)
      id = options.delete(:id) 
      connection.put("/data/#{name}/#{id}", options)   
    end
    
    def self.delete_item(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      raise ArgumentError, "Option :id must be present" unless options[:id]
      name = options.delete(:name)
      id = options.delete(:id) 
      connection.delete("/data/#{name}/#{id}", options)   
         
    end
  end
end