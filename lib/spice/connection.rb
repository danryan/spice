require 'rest-client'

module Spice
  class Connection
    attr_reader :auth_credentials
    attr_accessor :url, :default_headers
    
    def initialize(url, client_name, key_file, options={})
      @url = url
      @client_name = client_name
      @key_file = key_file
      @auth_credentials = Authentication.new(client_name, key_file)
      @sign_on_redirect, @sign_request = true, true
      @default_headers = options[:headers] || {}
    end
    
    def get(path, headers={})
      response = RestClient::Request.execute(
        :method => :GET,
        :url => "#{@url}/#{path}",
        :headers => build_headers(:GET, path)
      )
      JSON.parse(response)
    end
    
    def post(path, payload, headers={})
      response = RestClient::Request.execute(
        :method => :POST,
        :url => "#{@url}/#{path}",
        :headers => build_headers(:POST, path, headers, JSON.generate(payload)),
        :payload => JSON.generate(payload)
      )
      JSON.parse(response)
    end
    
    def clients
      # Client.all
      get("/clients").map {|c| Client.new(c[0])}
    end
    
    def cookbooks
      method = :GET
      path = "/cookbooks"
      response = RestClient::Request.execute(
        :method => method,
        :url => "#{@url}/#{path}",
        :headers => build_headers(method, path)
      )
      JSON.parse(response).inject([]) {|r, e| r << Cookbook.new(e[0])}
    end
    
    def data
      DataBag.all
    end
    
    alias :data_bags :data
    
    def environments
      # Not yet implemented
    end
    
    def nodes
      Node.all
      # node_hash = self.get_rest("/nodes")
      # @nodes ||= node_hash.map {|n| self.get_rest("/nodes/#{n[0]}") }
    end
    
    def roles
      Role.all
    end
    
    def search
    end
    
    def sandboxes
    end
    
    def sign_requests?
      auth_credentials.sign_requests? && @sign_request
    end
    
    def authentication_headers(method, path, json_body=nil)
      request_params = {
        :http_method => method, 
        :path => path,
        :body => json_body, 
        :host => url
      }
      request_params[:body] ||= ""
      auth_credentials.signature_headers(request_params)
    end
    
    def build_headers(method, path, headers={}, json_body=false, raw=false)
      headers = @default_headers.merge(headers)
      headers['Accept']       = "application/json" unless raw
      headers["Content-Type"] = 'application/json' if json_body
      headers['Content-Length'] = json_body.bytesize.to_s if json_body
      headers.merge!(authentication_headers(method, path, json_body)) if sign_requests?
      headers
    end
      
  end
end