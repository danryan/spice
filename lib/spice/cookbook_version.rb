require 'spice/persistence'

module Spice
  class CookbookVersion
    include Toy::Store
    include Spice::Persistence
    extend Spice::Persistence
    store :memory, {}
    endpoint "cookbooks"

    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, String
    attribute :version, String
    attribute :definitions, Array, :default => []
    attribute :attributes, Array, :default => []
    attribute :files, Array, :default => []
    attribute :providers, Array, :default => []
    attribute :metadata, Hash, :default => {}
    attribute :libraries, Array, :default => []
    attribute :templates, Array, :default => []
    attribute :resources, Array, :default => []
    attribute :attributes, Array, :default => []
    attribute :json_class, String, :default => "Chef::CookbookVersion"
    attribute :cookbook_name, String
    attribute :version, String
    attribute :recipes, Array, :default => []
    attribute :root_files, Array, :default => []
    attribute :chef_type, String, :default => "cookbook_version"
    
    validates_presence_of :name
    
    def do_post
      connection.put("/cookbooks/#{cookbook_name}/#{version}", attributes)
    end
    
    def do_put
      connection.put("/cookbooks/#{cookbook_name}/#{version}", attributes)
    end
    
    def do_delete
      connection.delete("/cookbooks/#{cookbook_name}/#{version}")
    end
    
    def self.get(name, version)
      connection.cookbook_version(name, version)
    end
    
    # Check if the cookbook version exists on the Chef server
    def new_record?
      begin
        connection.get("/cookbooks/#{name}/#{version}")
        return false
      rescue Spice::NotFound
        return true
      end
    end
  end
end