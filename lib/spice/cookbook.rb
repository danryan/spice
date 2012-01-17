require 'spice/persistence'

module Spice
  class Cookbook
    include Toy::Store
    include Spice::Persistence
    extend Spice::Persistence
    store :memory, {}
    endpoint "cookbooks"

    attribute :name, String
    attribute :versions, Array, :default => []

    validates_presence_of :name
    
    def self.get(name)
      connection.cookbook(name)
    end
    
    def new_record?
      begin
        connection.get("/cookbooks/#{name}")
        return false
      rescue Spice::NotFound
        return true
      end
    end
  end
end