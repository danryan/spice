module Spice
  class DataBagItem
    include Virtus
    include Aequitas
    include Spice::Persistence
    extend Spice::Persistence

    endpoint "data"
    
    # The _id attribute is used as the "id" field in the data bag item. 
    # "id" is an attribute reserved by ToyStore, the attribute system used by Spice.
    # @attribute [rw]
    # @return [String] the _attribute
    attribute :_id, String
    # @macro [attach] attribute
    # @attribute [rw]
    # @return [$2] the $1 attribute
    attribute :data, Hash, :default => {}    
    attribute :name, String
    
    validates_presence_of :_id, :name, :data
    
    def self.get(name, id)
      connection.data_bag_item(name, id)
    end
    
    def do_post
      attrs = data.dup
      attrs['id'] = attributes['_id']
      connection.post("/data/#{name}", attrs)
    end
    
    def do_put
      attrs = data.dup
      attrs['id'] = attributes['_id']
      connection.put("/data/#{name}/#{_id}", attrs)
    end
    
    def do_delete
      connection.delete("/data/#{name}/#{_id}")
    end
    
    # Check if the data bag item exists on the Chef server
    def new_record?
      begin
        connection.get("/data/#{name}/#{_id}")
        return false
      rescue Spice::Error::NotFound
        return true
      end
    end
  end
end