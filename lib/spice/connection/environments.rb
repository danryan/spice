module Spice
  class Connection
    module Environments
      def environments(options={})
        search('environment', options)
        get("/e").keys.map do |client|
          attributes = get("/clients/#{client}")
          Spice::Environment.new(attributes)
        end
      end

      def environment(name)
        attributes = get("/environments/#{name}")
        attributes['attrs'] = attributes.delete('attributes')
        Spice::Environment.new(attributes)
      end

    end # module Environments
  end # class Connection
end # module Spice