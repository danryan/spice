require 'faraday'
require 'yajl'

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
          Yajl.load(body)
        end
        
      end

    end
  end
end