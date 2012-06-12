require 'spice/base'

module Spice
  class CookbookVersion < Base
    attr_reader :name, :version, :definitions, :files, :providers, :metadata,
      :libraries, :templates, :resources, :attributes, :cookbook_name, 
      :recipes, :root_files

    def initialize(attrs=Mash.new)
      super
      @attrs['json_class'] ||= "Chef::CookbookVersion"
      @attrs['chef_type'] ||= 'cookbook_version'
    end
    
  end
end