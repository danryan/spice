require 'faraday'
require 'spice/core_ext/hash'
# require 'spice/request/auth'
# require 'spice/response/parse_json'
# require 'spice/response/client_error'

module Spice
  module Request
    
    def get(path, params=nil, options=Mash.new)
      request(:get, path, params, options)
    end
    
    def post(path, params=nil, options=Mash.new)
      request(:post, path, params, options)
    end
    
    def put(path, params=nil, options=Mash.new)
      request(:put, path, params, options)
    end
    
    def delete(path, params=nil, options=Mash.new)
      request(:delete, path, params, options)
    end
    
    private

    def connection
      # return @connection if defined? @connection
      
      default_options = {
        :headers => {
          :accept => 'application/json',
          :content_type => 'application/json',
          :user_agent => Spice.user_agent
        }
      }
      
      options = default_options.deep_merge(Spice.connection_options)
      
      # @connection = Faraday.new(Spice.server_url, options, &Spice.middleware)
      Faraday.new(Spice.server_url, options, &Spice.middleware)
    end

    def request(method, path, params, options)
      json_params = params ? Yajl.dump(params) : ""
      uri = Spice.server_url
      uri = URI(uri) unless uri.respond_to?(:host)
      uri += path
      
      headers = signature_headers(method.to_sym.upcase, uri.path, json_params)
      
      response = connection.run_request(method.to_sym, path, nil, headers) do |request|
        request.options[:raw] = true if options[:raw]
        unless params.nil?
          if request.method == :post || :put
            request.body = json_params
          else
            request.params.update params
          end
        end
        yield request if block_given?
      end

      options[:raw] ? response : response.body
      
    rescue Faraday::Error::ClientError
      raise Spice::Error::ClientError
    end
      
  end
end