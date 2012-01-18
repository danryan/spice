module Spice
  class Connection
    module Nodes
      # A collection of nodes
      # @param [Hash] options An options hash that is passed to {Search#search}
      # @return [Array<Spice::Node>]
      # @see Search#search
      # @example Retrieve all nodes that have the role "base"
      #   Spice.nodes(:q => "roles:base")
      # @example Retrieve nodes with role "base" in the "production" environment
      #   Spice.nodes(:q => "roles:base AND environment:production")
      def nodes(options={})
        connection.search('node', options)
      end

      # Retrieve a  single client
      # @param [String] name The node name
      # @return [Spice::Node]
      # @raise [Spice::Error::NotFound] raised when node does not exist
      # @example Retrieve the node named "app.example.com"
      #   Spice.node("app.example.com")
      def node(name)
        node_attributes = connection.get("/nodes/#{name}").body
        Spice::Node.new(node_attributes)
      end

    end # module Nodes
  end # class Connection
end # module Spice