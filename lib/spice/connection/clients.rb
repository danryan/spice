module Spice
  class Connection
    module Clients
      def clients(options={})
        search('client', options)
      end

      def client(name)
        attributes = get("/clients/#{name}").body
        Spice::Client.new(attributes)
      end

    end # module Clients
  end # class Connection
end # module Spice
