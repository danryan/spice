module Spice
  class Chef
    attr_accessor :client_name, :key_file, :connection
    
    def self.connection
      @connection ||= Spice.connection
    end
    
    class << self
      def clients
        @clients ||= Client.all
      end
    
      def nodes
        @nodes ||= Node.all
      end
    
      def data_bags
        @data_bags ||= DataBag.all
      end
      
      def roles
        @roles ||= Role.all
      end
      
      def cookbooks
        @cookbooks ||= Cookbook.all
      end
    end
  end
end

