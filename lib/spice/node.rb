require 'spice/base'

module Spice
  class Node < Base
    attr_reader :name, :normal, :override, :default, :automatic, :run_list,
      :json_class, :_rev, :chef_type, :chef_environment, :attributes, 
      :overrides, :defaults

    def initialize(attrs=Mash.new)
      super
      @attrs['json_class'] ||= "Chef::Node"
      @attrs['chef_type'] ||= 'node'
      @attrs['attributes'] ||= Mash.new
      @attrs['overrides'] ||= Mash.new
      @attrs['run_list'] ||= []
    end

  end
end