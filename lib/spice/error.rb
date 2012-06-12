module Spice
  class Error < StandardError
    attr_reader :http_headers, :wrapped_exception
    
    def initialize(exception=$!, http_headers={})
      @http_headers = http_headers
      if exception.respond_to?(:backtrace)
        super(exception.message)
        @wrapped_exception = exception
      else
        super(exception.to_s)
      end
    end
    
    def backtrace
      @wrapped_exception ? @wrapped_exception.backtrace : super
    end
    
  end
  
  class Error::BadRequest < Spice::Error
  end
  
  class Error::Unauthorized < Spice::Error
  end
  
  class Error::Forbidden < Spice::Error
  end
  
  class Error::NotFound < Spice::Error
  end
  
  class Error::NotAcceptable < Spice::Error
  end
  
  class Error::Conflict < Spice::Error
  end
  
  class Error::ClientError < Spice::Error
  end
  
end