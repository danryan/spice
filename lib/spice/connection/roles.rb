module Spice
  class Connection
    module Roles
      # A collection of roles
      # @param [Hash] options An options hash that is passed to {Search#search}
      # @return [Array<Spice::Role>]
      # @see Search#search
      # @example Retrieve all roles that start with "app_"
      #   Spice.roles(:q => "name:app_*")
      def roles(options=Mash.new)
        search('role', options)
      end # def roles

      # Retrieve a single role
      # @param [String] name The role name
      # @return [Spice::Role]
      # @raise [Spice::Error::NotFound] raised when role does not exist
      # @example Retrieve the role "app_server"
      #   Spice.role("app_server")
      def role(name)
        attributes = get("/roles/#{name}")
        Spice::Role.new(attributes)
      end # def role

    end # module Roles
  end # class Connection
end # module Spice