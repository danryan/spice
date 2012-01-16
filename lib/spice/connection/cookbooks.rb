module Spice
  class Connection
    module Cookbooks
      def cookbooks(options={})
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
      
      def cookbook_version(name, version)
        attributes = connection.get("/cookbooks/#{name}/#{version}").body
        Spice::CookbookVersion.new(attributes)
      end
      
    end # module Cookbooks
  end # class Connection
end # module Spice