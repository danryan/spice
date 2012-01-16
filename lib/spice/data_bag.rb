require 'spice/persistence'

module Spice
  class DataBag
    include Toy::Store
    include Spice::Persistence
    extend Spice::Persistence
    store :memory, {}
    endpoint "data"
    
    attribute :name, String
    attribute :items, Array, :default => []
    
    validates_presence_of :name

    def self.all
      connection.data_bags
    end
    
    def self.get(name)
      connection.data_bag(name)
    end
    
    def do_post
      response = connection.post("/data", attributes)
    end
  end
end