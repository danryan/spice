module Spice
  class Connection
    module DataBags
      def data_bags
        connection.get("/data").body.keys.map do |data_bag|
          items = connection.search(data_bag)
          Spice::DataBag.new(:name => data_bag, :items => items)
        end
      end

      alias :data :data_bags
      
      def data_bag(name)
        items = connection.search(name)
        Spice::DataBag.new(:name => name, :items => items)
      end

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