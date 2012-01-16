module Spice
  module Request
    class Auth < Faraday::Middleware
      
      def initialize(app, options)
        @app, @options = app, options
      end
      
      def call(env)
        
      end
    end
  end
end