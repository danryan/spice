module Spice
  class Connection
    module DataBags
      def data_bags
        get("/data").keys.map do |data_bag|
          items = get_data_bag_items(data_bag)
          Spice::DataBag.new(:name => data_bag, :items => items)
        end
      end

      def data_bag(name)
        items = get("/data/#{name}").keys.map do |item_id|
          data = get("/data/#{name}/#{item_id}")
          data.delete('id')
          Spice::DataBagItem.new(:_id => item_id, :data => data)
        end
        Spice::DataBag.new(:name => name, :items => items)
      end

      def data_bag_item(name, id)
        data = get("/data/#{name}/#{id}")
        data.delete('id')
        Spice::DataBagItem.new(:_id => id, :data => data)
      end

      private

      def get_data_bag_items(name)
        get("/data/#{name}").keys.map do |item_id|
          data = get("/data/#{name}/#{item_id}")
          Spice::DataBagItem.new(:_id => item_id, :data => data)
        end
      end

    end # module DataBags
  end # class Connection
end # module Spice