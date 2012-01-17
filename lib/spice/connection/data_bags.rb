module Spice
  class Connection
    module DataBags
      # Retrieve an array of all data bags
      # @return [Array<Spice::DataBag>]
      # @example Retrieve all data bags
      #   Spice.data_bags
      def data_bags
        connection.get("/data").body.keys.map do |data_bag|
          items = connection.search(data_bag)
          Spice::DataBag.new(:name => data_bag, :items => items)
        end
      end

      alias :data :data_bags
      
      # Retrieve a single data bag and its items
      # @param [String] name The data bag name
      # @return [Spice::DataBag]
      # @raise [Spice::NotFound] raised when data bag does not exist
      def data_bag(name)
        items = connection.search(name)
        Spice::DataBag.new(:name => name, :items => items)
      end

      # Retrieve a single data bag item
      # @param [String] name The data bag name
      # @param [String] id The data bag item id
      # @return [Spice::DataBagItem]
      # @raise [Spice::NotFound] raised when data bag item does not exist
      def data_bag_item(name, id)
        data = connection.get("/data/#{name}/#{id}")
        data.delete('id')
        Spice::DataBagItem.new(:_id => id, :data => data, :name => name)
      end

      private

      def get_data_bag_items(name)
        connection.get("/data/#{name}").body.keys.map do |id|
          data = connection.get("/data/#{name}/#{id}").body
          Spice::DataBagItem.new(:_id => id, :data => data, :name => name)
        end
      end

    end # module DataBags
  end # class Connection
end # module Spice