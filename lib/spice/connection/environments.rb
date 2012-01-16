module Spice
  class Connection
    module Environments
      def environments(options={})
        connection.search('environment', options)
      end

      def environment(name)
        attributes = connection.get("/environments/#{name}").body
        attributes['attrs'] = attributes.delete('attributes')
        Spice::Environment.new(attributes)
      end

    end # module Environments
  end # class Connection
end # module Spice