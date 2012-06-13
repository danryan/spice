require 'faraday'
require 'multi_json'

module Spice
  module Response
    class ParseJSON < Faraday::Response::Middleware
      
      def parse(body)
        case body
        when ''
          nil
        when 'true'
          true
        when 'false'
          false
        else
          MultiJson.load(body)
        end
      end # def parse
      
      def on_complete(env)
        if respond_to? :parse
          env[:body] = parse(env[:body]) unless env[:request][:raw] or [204,304].index env[:status]
        end
      end # def on_complete
      
    end
  end
end