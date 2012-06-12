module Spice
  class Connection
    module Environments
      # A collection of environments
      # @param [Hash] options An options hash that is passed to {Search#search}
      # @return [Array<Spice::Environment>]
      # @see Search#search
      # @example Retrieve all environments with names that begin with "prod"
      #   Spice.environments(:q => "name:prod*")
      def environments(options=Mash.new)
        search('environment', options)
      end # def environment

      # Retrieve a single environment
      # @param [String] name The environment name
      # @return [Spice::Environment]
      # @raise [Spice::Error::NotFound] raised when environment does not exist
      # @example Retrieve the environment named "production"
      #   Spice.environment("production")
      def environment(name)
        attributes = get("/environments/#{name}")
        Spice::Environment.get_or_new(attributes)
      end # def environment

    end # module Environments
  end # class Connection
end # module Spice