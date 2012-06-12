require 'spice/base'

module Spice
  class DataBagItem < Base
    attr_reader :name, :id, :chef_type
    
    def initialize(attrs=Mash.new)
      super
      @attrs['chef_type'] ||= 'data_bag_item'
    end
    
  end
end