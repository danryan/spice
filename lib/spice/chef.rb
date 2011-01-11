module Spice
  class Chef
    attr_accessor :client_name, :key_file, :connection
    
    # def initialize(options={})
    #   @client_name = options[:client_name] || Spice.client_name
    #   @key_file    = options[:key_file]    || Spice.key_file
    #   @host        = options[:host]        || Spice.host        
    #   @port        = options[:port]        || Spice.port
    #   @scheme      = options[:scheme]      || Spice.scheme
    #   # @connection  = Connection.new(
    #   #                  :url => "#{@scheme}://#{@host}:#{@port}", 
    #   #                  :client_name => options[:client_name], 
    #   #                  :key_file => options[:key_file]
    #   #                )                     || Spice.connection
    #   @connection = Spice.connection
    #   @sign_on_redirect, @sign_request = true, true       
    # end
    
    def self.connection
      @connection ||= Spice.connection
    end
    
    class << self
      def clients
        Client.all
      end
    
      def nodes
        Node.all
      end
    
      def data_bags
        DataBag.all
      end
      
      def roles
        Role.all
      end
      
      def cookbooks
        Cookbook.all
      end
    end
  end
end

