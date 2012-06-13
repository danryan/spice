module Spice
  class Connection
    module DataBags
      # Retrieve an array of all data bags
      # @return [Array<Spice::DataBag>]
      # @example Retrieve all data bags
      #   Spice.data_bags
      def data_bags
        get("/data").keys.map do |data_bag|
          items = search(data_bag)
          Spice::DataBag.get_or_new(:name => data_bag, :items => items)
        end
      end # def data_bags

      alias :data :data_bags
      
      # Retrieve a single data bag and its items
      # @param [String] name The data bag name
      # @return [Spice::DataBag]
      # @raise [Spice::Error::NotFound] raised when data bag does not exist
      def data_bag(name)
        items = search(name)
        Spice::DataBag.get_or_new(:name => name, :items => items)
      end # def data_bag

      # Retrieve a single data bag item
      # @param [String] name The data bag name
      # @param [String] id The data bag item id
      # @return [Spice::DataBagItem]
      # @raise [Spice::Error::NotFound] raised when data bag item does not exist
      def data_bag_item(name, id)
        data_bag_item = get("/data/#{name}/#{id}")
        Spice::DataBagItem.get_or_new(data_bag_item)
      end # def data_bag_item

      def create_data_bag(name)
        attributes = post("/data", :name => name)
        Spice::DataBag.get_or_new(:name => name, :items => [])
      end # def create_data_bag
      
      def create_data_bag_item(name, params=Mash.new)
        attributes = post("/data/#{name}", params)
        Spice::DataBagItem.get_or_new(attributes)
      end # def create_data_bag_item
      
      def update_data_bag_item(name, id, params=Mash.new)
        params.merge!(:id => id)
        attributes = put("/data/#{name}/#{id}", params)
        Spice::DataBagItem.get_or_new(attributes)
      end # update_data_bag_item
      
      def delete_data_bag_item(name, id)
        delete("/data/#{name}/#{id}")
        nil
      end # def delete_data_bag_item
      
    end # module DataBags
  end # class Connection
end # module Spice