require 'faraday'

module Spice
  module Response
    class ClientError < Faraday::Response::Middleware
      
      def on_complete(env)
        case env[:status].to_i
        when 400
          raise Spice::Error::BadRequest.new(error(env[:body]), env[:request_headers])
        when 401
          raise Spice::Error::Unauthorized.new(error(env[:body]), env[:request_headers])
        when 403
          raise Spice::Error::Forbidden.new(error(env[:body]), env[:request_headers])
        when 404
          raise Spice::Error::NotFound.new(error(env[:body]), env[:request_headers])
        when 406
          raise Spice::Error::NotAcceptable.new(error(env[:body]), env[:request_headers])
        when 409
          raise Spice::Error::Conflict.new(error(env[:body]), env[:request_headers])
        end
      end
      
      def error(body)
        if body["error"].kind_of?(Array)
          body["error"].join(',')
        else
          body["error"]
        end
      end
      
    end
  end
end