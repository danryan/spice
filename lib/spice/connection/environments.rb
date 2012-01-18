module Spice
  class Connection
    module Environments
      # A collection of environments
      # @param [Hash] options An options hash that is passed to {Search#search}
      # @return [Array<Spice::Environment>]
      # @see Search#search
      # @example Retrieve all environments with names that begin with "prod"
      #   Spice.environments(:q => "name:prod*")
      def environments(options={})
        connection.search('environment', options)
      end

      # Retrieve a single environment
      # @param [String] name The environment name
      # @return [Spice::Environment]
      # @raise [Spice::Error::NotFound] raised when environment does not exist
      # @example Retrieve the environment named "production"
      #   Spice.environment("production")
      def environment(name)
        attributes = connection.get("/environments/#{name}").body
        attributes['attrs'] = attributes.delete('attributes')
        Spice::Environment.new(attributes)
      end

    end # module Environments
  end # class Connection
end # module Spice