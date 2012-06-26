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
      def nodes(options=Mash.new)
        search('node', options)
      end # def nodes

      # Retrieve a  single client
      # @param [String] name The node name
      # @return [Spice::Node]
      # @raise [Spice::Error::NotFound] raised when node does not exist
      # @example Retrieve the node named "app.example.com"
      #   Spice.node("app.example.com")
      def node(name)
        attributes = get("/nodes/#{name}")
        Spice::Node.get_or_new(attributes)
      end # def node

      alias :get_node :node

      def create_node(params=Mash.new)
        node = Spice::Node.new(params)
        post("/nodes", node.attrs)
        get_node(node.name)
      end # def create_node

      # TODO(dryan): be able to update a node
      # def update_node(params=Mash.new)
      #   node = Spice::Node.new(params)
      #   node.attrs.update get_node(node.name)
      #   attributes = put("/nodes/#{node.name}", node.attrs)
      #   Spice::Node.get_or_new(attributes)
      # end
      
    end # module Nodes
  end # class Connection
end # module Spice