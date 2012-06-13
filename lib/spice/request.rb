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
          :user_agent => user_agent
        }
      }
      
      options = default_options.deep_merge(connection_options)
      
      # @connection = Faraday.new(Spice.server_url, options, &Spice.middleware)
      Faraday.new(server_url, options, &middleware)
    end

    def request(method, path, params, options)
      json_params = params ? Yajl.dump(params) : ""
      uri = server_url
      uri = URI(uri) unless uri.respond_to?(:host)
      uri += path
      
      headers = signature_headers(method.to_sym.upcase, uri.path, json_params)
      # puts headers.inspect
      # puts client_key.inspect
      response = connection.run_request(method.to_sym, path, nil, headers) do |request|
        request.options[:raw] = true if options[:raw]
        
        # puts request.inspect
        
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
      
      # File.open(File.expand_path("../../../spec/fixtures/#{path.gsub(/\?.*/, '')}.json", __FILE__), "w") do |f|
      #   f.write Yajl.dump(response.body)
      # end
      # 
    rescue Faraday::Error::ClientError
      raise Spice::Error::ClientError
    end
      
  end
end