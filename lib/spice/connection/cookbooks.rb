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
          get("/cookbooks?num_versions=all").each_pair do |key, value|
            versions = value['versions'].map{ |v| v['version'] }
            cookbooks << Spice::Cookbook.get_or_new(:name => key, :versions => versions)
          end
          cookbooks
        else
          get("/cookbooks").keys.map do |cookbook|
            cb = get("/cookbooks/#{cookbook}")
            Spice::Cookbook.get_or_new(:name => cookbook, :versions => cb[cookbook])
          end
        end
      end # def cookbooks

      # Retrieve a single cookbook
      # @param [String] name The name of the cookbook
      # @return [Spice::Cookbook]
      # @raise [Spice::Error::NotFound] raised when cookbook does not exist
      def cookbook(name)
        if Gem::Version.new(Spice.chef_version) >= Gem::Version.new("0.10.0")
          cookbook = get("/cookbooks/#{name}")
          versions = cookbook[name]['versions'].map{ |v| v['version'] }

          Spice::Cookbook.get_or_new(:name => name, :versions => versions)
        else
          cookbook = get("/cookbooks/#{name}")
          Spice::Cookbook.get_or_new(:name => name, :versions => cookbook[name])
        end
      end # def cookbook
      
      # Retrieve a single cookbook version
      # @param [String] name The cookbook name
      # @param [String] version The cookbook version
      # @return [Spice::CookbookVersion]
      # @raise [Spice::Error::NotFound] raised when cookbook version does not exist
      def cookbook_version(name, version)
        attributes = get("/cookbooks/#{name}/#{version}")
        duped_attributes = attributes.dup
        duped_attributes[:_attributes] = attributes['attributes']
        Spice::CookbookVersion.get_or_new(duped_attributes)
      end # def cookbook_version
      
      def delete_cookbook_version(name, version)
        delete("/cookbooks/#{name}/#{version}")
        nil
      end # def delete_cookbook_version
      
    end # module Cookbooks
  end # class Connection
end # module Spice