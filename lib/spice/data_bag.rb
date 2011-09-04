module Spice
  class DataBag < Spice::Chef
    # Get a list of all data bags in the following syntax
    #     Spice::DataBag.all
    #    
    # @param [Hash] options the options hash. Currently does nothing
    def self.all(options={})
      connection.get("/data")
    end
    
    # An alternative format for showing the contents of a data bag
    # @example Retrieve the id and uri of items in a data bag called "users"
    #   Spice::DataBag["users"] # => {"adam":"http://localhost:4000/data/users/adam"}
    def self.[](name)
      connection.get("/data/#{name}")
    end
    
    # Show the contents of a data bag
    # @example Retrieve the id and uri of items in a data bag called "users"
    #   Spice::DataBag.show(:name => "users") # => {"adam":"http://localhost:4000/data/users/adam"}
    # 
    # @param [Hash] options The options hash
    # @option options [String] :name The name of your data bag
    def self.show(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.get("/data/#{name}")
    end
    
    # Create a a new data bag
    # 
    # @example 
    #   Spice::DataBag.create(:name => "users")
    #
    # @param [Hash] options the options hash from which to create a data bag
    # @option options [String] :name The name of your data bag    
    
    def self.create(options={})
      connection.post("/data", options)
    end

    # Delete a data bag
    # 
    # @example 
    #   Spice::DataBag.delete(:name => "users")
    #
    # @param [Hash] options the options hash from which to delete a data bag
    # @option options [String] :name The name of your data bag    

    def self.delete(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      name = options.delete(:name)
      connection.delete("/data/#{name}", options)
    end
    
    # Shows a data bag item
    # 
    # @example 
    #   Spice::DataBag.show_item(:name => "users", :id => "adam")
    #
    # @param [Hash] options the options hash from which to create a data bag
    # @option options [String] :name The name of your data bag    
    # @option options [String] :id The id of the data bag item
    
    def self.show_item(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      raise ArgumentError, "Option :id must be present" unless options[:id]
      name = options.delete(:name)
      id = options.delete(:id)
      connection.get("/data/#{name}/#{id}", options)
    end
    
    # Creates a data bag item
    # 
    # @example 
    #   Spice::DataBag.create_item(:name => "users", :id => "adam", :title => "Supreme Awesomer")
    #
    # @param [Hash] options the options hash from which to create a data bag
    # @option options [String] :name The name of your data bag    
    # @option options [String] :id The id of the data bag item
    # 
    # Any additional keys in the options hash will be used as attributes 
    # to be stored in the data bag item
    
    def self.create_item(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      raise ArgumentError, "Option :id must be present" unless options[:id]
      name = options.delete(:name)
      connection.post("/data/#{name}", options)   
      
    end
    
    # Update a data bag item
    # 
    # @example 
    #   Spice::DataBag.update_item(:name => "users", :id => "adam", :title => "Supreme Awesomer")
    #
    # @param [Hash] options the options hash from which to update a data bag
    # @option options [String] :name The name of your data bag    
    # @option options [String] :id The id of the data bag item
    # 
    # Any additional keys in the options hash will be used as attributes 
    # to be stored in the data bag item
    
    def self.update_item(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      raise ArgumentError, "Option :id must be present" unless options[:id]  
      name = options.delete(:name)
      id = options.delete(:id) 
      connection.put("/data/#{name}/#{id}", options)   
    end
    
    # Delete a data bag item
    # 
    # @example 
    #   Spice::DataBag.delete_item(:name => "users", :id => "adam")
    #
    # @param [Hash] options the options hash from which to delete a data bag
    # @option options [String] :name The name of your data bag    
    # @option options [String] :id The id of the data bag item
    #
    
    def self.delete_item(options={})
      raise ArgumentError, "Option :name must be present" unless options[:name]
      raise ArgumentError, "Option :id must be present" unless options[:id]
      name = options.delete(:name)
      id = options.delete(:id) 
      connection.delete("/data/#{name}/#{id}", options)   
         
    end
  end
end