module Spice
  class Connection
    module Cookbooks
      # Retrieve an array of all cookbooks
      # @return [Array<Spice::Cookbook>]
      # @example Retrieve all cookbooks with versions
      #   Spice.cookbooks
      def cookbooks
        if Gem::Version.new(Spice.chef_version) >= Gem::Version.new("0.10.0")
          cookbooks = []
          connection.get("/cookbooks").body.each_pair do |key, value|
            versions = value['versions'].map{ |v| v['version'] }
            cookbooks << Spice::Cookbook.new(:name => key, :versions => versions)
          end
          cookbooks
        else
          connection.get("/cookbooks").body.keys.map do |cookbook|
            attributes = connection.get("/cookbooks/#{cookbook}").body.to_a[0]
            Spice::Cookbook.new(:name => attributes[0], :versions => attributes[1])
          end
        end
      end

      # Retrieve a single cookbook
      # @param [String] name The name of the cookbook
      # @return [Spice::Cookbook]
      # @raise [Spice::Error::NotFound] raised when cookbook does not exist
      def cookbook(name)
        if Gem::Version.new(Spice.chef_version) >= Gem::Version.new("0.10.0")
          cookbook = connection.get("/cookbooks/#{name}").body
          puts cookbook[name]
          versions = cookbook[name]['versions'].map{ |v| v['version'] }

          Spice::Cookbook.new(:name => name, :versions => versions)
        else
          connection.get("/cookbooks").body.keys.map do |cookbook|
            attributes = connection.get("/cookbooks/#{cookbook}").body.to_a[0]
            Spice::Cookbook.new(:name => attributes[0], :versions => attributes[1])
          end
        end
      end
      
      # Retrieve a single cookbook version
      # @param [String] name The cookbook name
      # @param [String] version The cookbook version
      # @return [Spice::CookbookVersion]
      # @raise [Spice::Error::NotFound] raised when cookbook version does not exist
      def cookbook_version(name, version)
        attributes = connection.get("/cookbooks/#{name}/#{version}").body
        Spice::CookbookVersion.new(attributes)
      end
      
    end # module Cookbooks
  end # class Connection
end # module Spice