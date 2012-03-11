require 'spice/persistence'

module Spice
  class DataBag
    include Virtus
    include Aequitas
    include Spice::Persistence
    extend Spice::Persistence

    endpoint "data"
    
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
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
    
    # Check if the data bag exists on the Chef server
    def new_record?
      begin
        connection.get("/data/#{name}")
        return false
      rescue Spice::Error::NotFound
        return true
      end
    end
  end
end