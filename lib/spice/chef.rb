module Spice
  class Chef
    attr_accessor :host, :client_name, :key_file, :port, :path, :scheme, :connection
    
    def initialize(options={})
      @@client_name ||= @client_name = options[:client_name]
      @@key_file    ||= @key_file = options[:key_file]
      @@host        ||= @host   = options[:host]   || 'localhost'
      @@port        ||= @port   = options[:port]   || 4000
      @@path        ||= @path   = options[:path]   || '/'
      @@scheme      ||= @scheme = options[:scheme] || 'http'
      @@connection  ||= @connection = Connection.new(
                           :url => "#{@scheme}://#{@host}:#{@port}#{@path}", 
                           :client_name => options[:client_name], 
                           :key_file => options[:key_file]
                         )
      @default_headers = options[:headers] || {}
      @sign_on_redirect, @sign_request = true, true       
    end
    
    def connection
      @@connection
    end
    
    def self.connection
      @@connection
    end
    
    def clients
      self.connection.get("/clients")
    end
    
    def nodes
      self.connection.get("/nodes")
    end
    
    def data_bags
      self.connection.get("/data")
    end
  end
end

