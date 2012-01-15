module Spice
  class Connection
    module Cookbooks
      def cookbooks
        get("/cookbooks").keys.map do |cookbook|
          attributes = get("/cookbooks/#{cookbook}")
          Spice::Cookbook.new(attributes)
        end
      end

      def cookbook(name)
        attributes = get("/cookbooks/#{name}")
        Spice::Cookbook.new(attributes)
      end
      
    end # module Cookbooks
  end # class Connection
end # module Spice