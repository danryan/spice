require 'spice/base'

module Spice
  class Client < Base
    attr_reader :name, :public_key, :private_key, :_rev, :admin
    
    def initialize(attrs=Mash.new)
      super
      @attrs['json_class'] ||= "Chef::ApiClient"
      @attrs['chef_type'] ||= 'client'
      @attrs['admin'] ||= false
    end

  end
end