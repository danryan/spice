module Spice
  class Connection
    module Clients
      def clients(options={})
        connection.search('client', options)
      end

      def client(name)
        attributes = connection.get("/clients/#{name}").body
        Spice::Client.new(attributes)
      end

    end # module Clients
  end # class Connection
end # module Spice
