module Spice
  class DataBagItem
    include Toy::Store
    store :memory, {}
    
    attribute :_id, String
    attribute :data, Hash, :default => {}
    # attribute :json_class, String, :default => "Chef::DataBagItem"
  end
end