module Spice
  class Connection
    module Roles
      def roles(options={})
        search('role', options)
      end

      def role(name)
        attributes = get("/roles/#{name}")
        Spice::Role.new(attributes)
      end

    end # module Roles
  end # class Connection
end # module Spice