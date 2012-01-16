require 'yajl'
require 'uri'

require 'spice/request'
require 'spice/connection/authentication'
require 'spice/connection/search'
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
    include Spice::Connection::Authentication
    include Spice::Connection::Search
    include Spice::Request
        
    attribute :client_name, String
    attribute :key_file, String
    attribute :key, String
    attribute :server_url, String
    attribute :sign_on_redirect, Boolean, :default => true
    attribute :sign_request, Boolean, :default => true
    attribute :endpoint, String
    
    validates_presence_of :client_name, :key_file, :server_url
    
    def connection
      self
    end
    
    def parsed_url
      URI.parse(server_url)
    end

    def get(path)
      response = request(:headers => build_headers(
        :GET, 
        "#{parsed_url.path}#{path}")
      ).get(
        "#{server_url}#{path}"
      )
      return response
    end # def get
    
    def post(path, payload)
      response = request(:headers => build_headers(
        :POST, 
        "#{parsed_url.path}#{path}", 
        Yajl.dump(payload))
      ).post(
        "#{server_url}#{path}", 
        Yajl.dump(payload)
      )
      return response
    end # def post
    
    def put(path, payload, headers={})
      response = request(:headers => build_headers(
        :PUT, 
        "#{parsed_url.path}#{path}", 
        Yajl.dump(payload))
      ).put(
        "#{server_url}#{path}", 
        Yajl.dump(payload)
      )
      return response
    end # def put
    
    def delete(path, headers={})
      response = request(:headers => build_headers(
        :DELETE, 
        "#{parsed_url.path}#{path}")
      ).delete(
        "#{server_url}#{path}"
      )
      return response
    end # def delete
    
    private
    
    def authentication_headers(method, path, json_body=nil)
      request_params = {
        :http_method => method, 
        :path => path.gsub(/\?.*$/, ''),
        :body => json_body, 
        :host => "#{parsed_url.host}:#{parsed_url.port}"
      }
      request_params[:body] ||= ""
      signature_headers(request_params)
    end # def authentication_headers
    
    def build_headers(method, path, json_body=nil)
      headers={}
      # headers['Accept']       = "application/json"
      # headers["Content-Type"] = 'application/json' if json_body
      headers['Content-Length'] = json_body.bytesize.to_s if json_body
      headers.merge!(authentication_headers(method, path, json_body)) if sign_requests?
      headers
    end # def build_headers

  end # class Connection
end # module Spice