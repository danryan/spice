require 'faraday'
# require 'spice/request/auth'
require 'spice/response/parse_json'
require 'spice/response/client_error'

module Spice
  module Request
    def request(options={})
      default_options = {
        :headers => {
          :accept => 'application/json',
          :content_type => 'application/json',
          :user_agent => Spice.user_agent
        }
      }

      Faraday.new(
        default_options.deep_merge(Spice.connection_options).deep_merge(options)
      ) do |builder|
        # builder.use Spice::Request::Auth
        builder.use Spice::Response::ClientError
        builder.use Spice::Response::ParseJSON
        builder.adapter(:net_http)
      end
    end
  end
end