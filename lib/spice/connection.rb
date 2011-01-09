require 'rest-client'

module Spice
  class Connection
    attr_accessor :client_name, :key_file, :auth_credentials, :url, :path, :port, :scheme
    
    def initialize(options={})
      endpoint          = URI.parse(options[:url])
      @url              = options[:url]
      @host             = endpoint.host
      @scheme           = endpoint.scheme
      @port             = endpoint.port
      @path             = endpoint.path
      @path = URI.parse(@url).path
      @auth_credentials = Authentication.new(options[:client_name], options[:key_file])
      @sign_on_redirect, @sign_request = true, true
    end
    
    def get(path, headers={})
      response = RestClient::Request.execute(
        :method => :GET,
        :url => "#{@url}#{path}",
        :headers => build_headers(:GET, path, headers)
      )
      JSON.parse(response)
    end
    
    def post(path, payload, headers={})
      response = RestClient::Request.execute(
        :method => :POST,
        :url => "#{@url}#{path}",
        :headers => build_headers(:POST, path, headers, JSON.generate(payload)),
        :payload => JSON.generate(payload)
      )
      JSON.parse(response)
    end
    
    def put(path, payload, headers={})
      response = RestClient::Request.execute(
        :method => :PUT,
        :url => "#{@url}#{path}",
        :headers => build_headers(:PUT, path, headers, JSON.generate(payload)),
        :payload => JSON.generate(payload)
      )
      JSON.parse(response)
    end
    
    def delete(path, payload, headers={})
      response = RestClient::Request.execute(
        :method => :DELETE,
        :url => "#{@url}#{path}",
        :headers => build_headers(:DELETE, path, headers, JSON.generate(payload)),
        :payload => JSON.generate(payload)
      )
      JSON.parse(response)
    end  
    
    def sign_requests?
      auth_credentials.sign_requests? && @sign_request
    end
    
    private
    
    def authentication_headers(method, path, json_body=nil)
      request_params = {
        :http_method => method, 
        :path => path,
        :body => json_body, 
        :host => "#{@scheme}://#{@host}:#{@port}#{@path}"
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