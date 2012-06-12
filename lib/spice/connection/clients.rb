module Spice
  class Connection
    module Clients
      # A collection of clients
      # @param [Hash] options An options hash that is passed to {Search#search}
      # @return [Array<Spice::Client>, Array]
      # @see Search#search
      # @example Retrieve all clients with names that begin with "app"
      #   Spice.clients(:q => "name:app*")
      def clients(options=Mash.new)
        search('client', options)
      end # def clients

      # Retrieve a single client
      # @param [String] name The client name
      # @return [Spice::Client]
      # @raise [Spice::Error::NotFound] raised when client does not exist
      # @example Retrieve the client named "admin"
      #   Spice.client("name")
      def client(name)
        attributes = get("/clients/#{name}")
        Spice::Client.get_or_new(attributes)
      end # def client
      
      def create_client(params=Mash.new)
        attributes = post("/clients", params)
        Spice::Client.get_or_new(attributes)
      end # def create_client
      
      def update_client(name, params=Mash.new)
        attributes = put("/clients/#{name}", params)
        Spice::Client.get_or_new(attributes)
      end # def update_client
      
      def delete_client(name)
        client = delete("/clients/#{name}")
        nil
      end # def delete_client

      def reregister_client(name)
        attributes = put("/clients/#{name}", :private_key => true)
        Spice::Client.get_or_new(attributes)
      end # def reregister_client
      
    end # module Clients
  end # class Connection
end # module Spice
