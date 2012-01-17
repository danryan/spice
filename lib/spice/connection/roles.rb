module Spice
  class Connection
    module Roles
      # A collection of roles
      # @param [Hash] options An options hash that is passed to {Search#search}
      # @return [Array<Spice::Role>]
      # @see Search#search
      # @example Retrieve all roles that start with "app_"
      #   Spice.roles(:q => "name:app_*")
      def roles(options={})
        connection.search('role', options)
      end

      # Retrieve a single role
      # @param [String] name The role name
      # @return [Spice::Role]
      # @raise [Spice::NotFound] raised when role does not exist
      # @example Retrieve the role "app_server"
      #   Spice.role("app_server")
      def role(name)
        attributes = connection.get("/roles/#{name}").body
        Spice::Role.new(attributes)
      end

    end # module Roles
  end # class Connection
end # module Spice