require 'yajl/json_gem'

module Spice
  class Connection
    attr_accessor :client_name, :key_file, :auth_credentials, :url, :path, :port, :scheme, :host
    
    def initialize(options={})
      endpoint          = URI.parse(options[:url])
      @url              = options[:url]
      @host             = endpoint.host
      @scheme           = endpoint.scheme
      @port             = endpoint.port
      @url_path         = endpoint.path
      @auth_credentials = Authentication.new(options[:client_name], options[:key_file])
      @sign_on_redirect, @sign_request = true, true
    end
    
    def get(path, headers={})
      begin
        RestClient.get(
          "#{@url}#{path}", 
          build_headers(:GET, "#{@url_path}#{path}", headers)
        )
      rescue => e
        e.response
      end
    end
    
    def post(path, payload, headers={})
      begin
        RestClient.post(
          "#{@url}#{path}",
          JSON.generate(payload),
          build_headers(:POST, "#{@url_path}#{path}", headers, JSON.generate(payload))
        )
      rescue => e
        e.response
      end
    end
    
    def put(path, payload, headers={})
      begin
        RestClient.put(
          "#{@url}#{path}",
          JSON.generate(payload),
          build_headers(:PUT, "#{@url_path}#{path}", headers, JSON.generate(payload))
        )
      rescue => e
        e.response
      end
    end
    
    def delete(path, headers={})
      begin
        RestClient.delete(
          "#{@url}#{path}",
          build_headers(:DELETE, "#{@url_path}#{path}", headers)
        )
      rescue => e
        e.response
      end
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
        :host => "#{@host}:#{@port}"
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