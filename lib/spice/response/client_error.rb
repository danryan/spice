require 'faraday'

module Spice
  module Response
    class ClientError < Faraday::Response::Middleware
      
      def on_complete(env)
        case env[:status].to_i
        when 400
          raise Spice::BadRequest.new(error(env[:body]), env[:request_headers])
        when 401
          raise Spice::Unauthorized.new(error(env[:body]), env[:request_headers])
        when 403
          raise Spice::Forbidden.new(error(env[:body]), env[:request_headers])
        when 404
          raise Spice::NotFound.new(error(env[:body]), env[:request_headers])
        when 406
          raise Spice::NotAcceptable.new(error(env[:body]), env[:request_headers])
        when 409
          raise Spice::Conflict.new(error(env[:body]), env[:request_headers])
        end
      end
      
      def error(body)
        body["error"].join(',')
      end
      
    end
  end
end