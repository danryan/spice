require 'yajl'

module Spice
  class Connection
    attr_accessor :client_name, :key_file, :auth_credentials, :server_url, :url_path
    
    def initialize(options={})
      endpoint          = URI.parse(options[:server_url])
      @server_url       = options[:server_url]
      @host             = endpoint.host
      @port             = endpoint.port
      @scheme           = endpoint.scheme
      @url_path         = endpoint.path
      @auth_credentials = Authentication.new(options[:client_name], options[:key_file])
      @sign_on_redirect, @sign_request = true, true
    end
    
    def get(path, headers={})
      begin
        response = RestClient.get(
          "#{@server_url}#{path}", 
          build_headers(:GET, "#{@url_path}#{path}", headers)
        )
        return Yajl.load(response.body)
       
      rescue => e
        e.response
      end
    end
    
    def post(path, payload, headers={})
      begin
        response = RestClient.post(
          "#{@server_url}#{path}",
          Yajl.dump(payload),
          build_headers(:POST, "#{@url_path}#{path}", headers, Yajl.dump(payload))
        )      
        return Yajl.load(response.body)
          
      rescue => e
        e.response
      end
    end
    
    def put(path, payload, headers={})
      begin
        response = RestClient.put(
        "#{@server_url}#{path}",
          Yajl.dump(payload),
          build_headers(:PUT, "#{@url_path}#{path}", headers, Yajl.dump(payload))
        )
        return Yajl.load(response.body)
        
      rescue => e
        e.response
      end
    end
    
    def delete(path, headers={})
      begin
        response = RestClient.delete(
        "#{@server_url}#{path}",
          build_headers(:DELETE, "#{@url_path}#{path}", headers)
        )
        return Yajl.load(response.body)
        
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
        :path => path.gsub(/\?.*$/, ''),
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