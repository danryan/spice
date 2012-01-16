module Spice
  class Connection
    module Roles
      def roles(options={})
        connection.search('role', options)
      end

      def role(name)
        attributes = connection.get("/roles/#{name}").body
        Spice::Role.new(attributes)
      end

    end # module Roles
  end # class Connection
end # module Spice