require 'spice/persistence'

module Spice
  class CookbookVersion
    include ActiveAttr::Model

    include Spice::Persistence
    extend Spice::Persistence

    endpoint "cookbooks"

    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :name, :type => String
    attribute :version, :type => String
    attribute :definitions, :type => Array, :default => []
    attribute :files, :type => Array, :default => []
    attribute :providers, :type => Array, :default => []
    attribute :metadata, :type => Hash, :default => {}
    attribute :libraries, :type => Array, :default => []
    attribute :templates, :type => Array, :default => []
    attribute :resources, :type => Array, :default => []
    attribute :_attributes, :type => Array, :default => []
    attribute :json_class, :type => String, :default => "Chef::CookbookVersion"
    attribute :cookbook_name, :type => String
    attribute :version, :type => String
    attribute :recipes, :type => Array, :default => []
    attribute :root_files, :type => Array, :default => []
    attribute :chef_type, :type => String, :default => "cookbook_version"
    
    validates_presence_of :name
    
    def do_post
      duped_attributes = attributes.dup
      duped_attributes[:attributes] = attributes[:_attributes]
      duped_attributes.delete(:_attributes)
      
      connection.put("/cookbooks/#{cookbook_name}/#{version}", duped_attributes)
    end
    
    def do_put
      duped_attributes = attributes.dup
      duped_attributes[:attributes] = attributes[:_attributes]
      duped_attributes.delete(:_attributes)
      
      connection.put("/cookbooks/#{cookbook_name}/#{version}", duped_attributes)
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
        connection.get("/cookbooks/#{name.split('-').first}/#{version}")
        return false
      rescue Spice::Error::NotFound
        return true
      end
    end
  end
end