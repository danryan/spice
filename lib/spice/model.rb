module Spice
  class Model
    extend Spice::Attributes::ClassMethods
    include Spice::Attributes::InstanceMethods
    
    attr_accessor :collection, :connection
    
    def initialize(new_attributes={})
      merge_attributes(new_attributes)
    end
    
    def reload
      requires :identity
      if data = collection.get(identity)
        new_attributes = data.attributes
        merge_attributes(new_attributes)
        self
      end
    end
    
    def to_json
      attributes.to_json
    end
  end
end
    