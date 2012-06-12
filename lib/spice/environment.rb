require 'spice/base'

module Spice
  class Environment < Base
    attr_reader :name, :description, :attributes, :cookbook_versions, 
      :chef_type, :json_class
      
    def json_class
      @json_class ||= "Chef::Environment"
    end

    def chef_type
      @chef_type ||= 'environment'
    end 

  end
end