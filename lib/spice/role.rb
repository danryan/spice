require 'spice/base'

module Spice
  class Role < Base
    attr_reader :name, :description, :override_attributes, :default_attributes,
      :run_list, :env_run_lists, :_rev, :json_class, :chef_type

    def initialize(attrs=Mash.new)
      super
      @attrs['json_class'] ||= "Chef::Role"
      @attrs['chef_type'] ||= 'role'
    end
  end
end