require 'yajl'
require 'spice/connection/clients'
require 'spice/connection/cookbooks'
require 'spice/connection/data_bags'
require 'spice/connection/environments'
require 'spice/connection/nodes'
require 'spice/connection/roles'
require 'spice/connection/search'

module Spice
  class Connection
    include Toy::Store
    store :memory, {}
    
    include Spice::Connection::Clients
    include Spice::Connection::Cookbooks
    include Spice::Connection::DataBags
    include Spice::Connection::Environments
    include Spice::Connection::Nodes
    include Spice::Connection::Roles
    include Spice::Connection::Search
    
    attr_accessor :auth_credentials
    
    attribute :client_name, String
    attribute :key_file, String
    attribute :server_url, String, :default => lambda { Spice.default_server_url }
    attribute :sign_on_redirect, Boolean, :default => true
    attribute :sign_request, Boolean, :default => true

    validates_presence_of :client_name, :key_file, :server_url
    
    def auth_credentials
      Spice::Authentication.new(client_name, key_file)
    end
    
    def parsed_url
      URI.parse(server_url)
    end
    
    def get(path, headers={})
      begin
        response = RestClient.get(
          "#{server_url}#{path}", 
          build_headers(:GET, "#{parsed_url.path}#{path}", headers)
        )
        return Yajl.load(response.body)
       
      rescue => e
        e.response
      end
    end
    
    def post(path, payload, headers={})
      begin
        response = RestClient.post(
          "#{server_url}#{path}",
          Yajl.dump(payload),
          build_headers(:POST, "#{parsed_url.path}#{path}", headers, Yajl.dump(payload))
        )      
        return Yajl.load(response.body)
          
      rescue => e
        e.response
      end
    end
    
    def put(path, payload, headers={})
      begin
        response = RestClient.put(
        "#{server_url}#{path}",
          Yajl.dump(payload),
          build_headers(:PUT, "#{parsed_url.path}#{path}", headers, Yajl.dump(payload))
        )
        return Yajl.load(response.body)
        
      rescue => e
        e.response
      end
    end
    
    def delete(path, headers={})
      begin
        response = RestClient.delete(
        "#{server_url}#{path}",
          build_headers(:DELETE, "#{parsed_url.path}#{path}", headers)
        )
        return Yajl.load(response.body)
        
      rescue => e
        e.response
      end
    end  
    
    def sign_requests?
      sign_request
    end
    
    private
    
    def authentication_headers(method, path, json_body=nil)
      request_params = {
        :http_method => method, 
        :path => path.gsub(/\?.*$/, ''),
        :body => json_body, 
        :host => "#{parsed_url.host}:#{parsed_url.port}"
      }
      request_params[:body] ||= ""
      auth_credentials.signature_headers(request_params)
    end
    
    def build_headers(method, path, headers={}, json_body=false)
      headers['Accept']       = "application/json"
      headers["Content-Type"] = 'application/json' if json_body
      headers['Content-Length'] = json_body.bytesize.to_s if json_body
      headers.merge!(authentication_headers(method, path, json_body)) if sign_requests?
      headers
    end
  end
end