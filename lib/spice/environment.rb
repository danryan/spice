module Spice
  class Environment
    include Toy::Store
    store :memory, {}
    
    attribute :name, String
    attribute :description, String
    attribute :attrs, Hash, :default => {}
    attribute :json_class, String, :default => "Chef::Environment"
    attribute :chef_type, String, :default => "environment"
    attribute :cookbook_versions, Hash, :default => {}
    
    validates_presence_of :name, :description
    
    # Get a list of all data bags in the following syntax
        #     Spice::Environment.all
        #    
        # @param [Hash] options the options hash. Currently does nothing
        # def self.all(options={})
        #   connection.get("/environments")
        # end
    #     
    #     # An alternative format for showing the contents of a data bag
    #     # @example Retrieve the id and uri of items in a data bag called "users"
    #     #   Spice::Environment["users"] # => {"adam":"http://localhost:4000/data/users/adam"}
    #     def self.[](name)
    #       connection.get("/environments/#{name}")
    #     end
    #     
    #     # Show the contents of a data bag
    #     # @example Retrieve the id and uri of items in a data bag called "users"
    #     #   Spice::Environment.show(:name => "users") # => {"adam":"http://localhost:4000/data/users/adam"}
    #     # 
    #     # @param [Hash] options The options hash
    #     # @option options [String] :name The name of your data bag
    #     def self.show(options={})
    #       raise ArgumentError, "Option :name must be present" unless options[:name]
    #       name = options.delete(:name)
    #       connection.get("/environments/#{name}")
    #     end
    #     
    #     # Create a a new data bag
    #     # 
    #     # @example 
    #     #   Spice::Environment.create(:name => "users")
    #     #
    #     # @param [Hash] options the options hash from which to create a data bag
    #     # @option options [String] :name The name of your data bag    
    #     
    #     def self.create(options={})
    #       options[:chef_type] ||= "environment"
    #       options[:json_class] ||= "Chef::Environment"
    #       options[:attributes] ||= {}
    #       options[:description] ||= ""
    #       options[:cookbook_versions] ||= {}
    #       connection.post("/environments", options)
    #     end
    # 
    #     # Delete a data bag
    #     # 
    #     # @example 
    #     #   Spice::Environment.delete(:name => "users")
    #     #
    #     # @param [Hash] options the options hash from which to delete a data bag
    #     # @option options [String] :name The name of your data bag    
    # 
    #     def self.delete(options={})
    #       raise ArgumentError, "Option :name must be present" unless options[:name]
    #       name = options.delete(:name)
    #       connection.delete("/environments/#{name}", options)
    #     end
    #     
    #     # Shows a data bag item
    #     # 
    #     # @example 
    #     #   Spice::Environment.show_item(:name => "users", :id => "adam")
    #     #
    #     # @param [Hash] options the options hash from which to create a data bag
    #     # @option options [String] :name The name of your data bag    
    #     # @option options [String] :id The id of the data bag item
    #     
    #     def self.show_cookbook(options={})
    #       raise ArgumentError, "Option :name must be present" unless options[:name]
    #       raise ArgumentError, "Option :cookbook must be present" unless options[:cookbook]
    #       name = options.delete(:name)
    #       cookbook = options.delete(:cookbook)
    #       connection.get("/environments/#{name}/cookbooks/#{cookbook}", options)
    #     end
    #     
    #     def self.list_cookbooks(options={})
    #       raise ArgumentError, "Option :name must be present" unless options[:name]
    #       name = options.delete(:name)
    #       connection.get("/environments/#{name}/cookbooks", options)
    #     end

  end
end