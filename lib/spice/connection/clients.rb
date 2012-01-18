module Spice
  class Connection
    module Clients
      # A collection of clients
      # @param [Hash] options An options hash that is passed to {Search#search}
      # @return [Array<Spice::Client>, Array]
      # @see Search#search
      # @example Retrieve all clients with names that begin with "app"
      #   Spice.clients(:q => "name:app*")
      def clients(options={})
        connection.search('client', options)
      end

      # Retrieve a single client
      # @param [String] name The client name
      # @return [Spice::Client]
      # @raise [Spice::Error::NotFound] raised when client does not exist
      # @example Retrieve the client named "admin"
      #   Spice.client("name")
      def client(name)
        attributes = connection.get("/clients/#{name}").body
        Spice::Client.new(attributes)
      end

    end # module Clients
  end # class Connection
end # module Spice
