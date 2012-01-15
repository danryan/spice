module Spice
  class Connection
    module Nodes
      def nodes(options={})
        search('node', options)
      end

      def node(name)
        node_attributes = get("/nodes/#{name}")
        Spice::Node.new(node_attributes)
      end

    end # module Nodes
  end # class Connection
end # module Spice