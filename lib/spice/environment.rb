require 'spice/base'

module Spice
  class Environment < Base
    attr_reader :name, :description, :attributes, :cookbook_versions, 
      :chef_type, :json_class
      
    def initialize(attrs=Mash.new)
      super
      @attrs['json_class'] ||= "Chef::Environment"
      @attrs['chef_type'] ||= "environment"
      @attrs['attributes'] ||= Mash.new
      @attrs['cookbook_version'] ||= Mash.new
    end

  end
end