module Spice
  class Connection
    module Nodes
      def nodes(options={})
        connection.search('node', options)
      end

      def node(name)
        node_attributes = connection.get("/nodes/#{name}").body
        Spice::Node.new(node_attributes)
      end

    end # module Nodes
  end # class Connection
end # module Spice