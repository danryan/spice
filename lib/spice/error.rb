module Spice
  class Error < StandardError
    attr_reader :http_headers
    
    def initialize(message, http_headers)
      @http_headers = Hash[http_headers]
      super(message)
    end
    
  end
  
  class Error::BadRequest < Error
  end
  
  class Error::Unauthorized < Error
  end
  
  class Error::Forbidden < Error
  end
  
  class Error::NotFound < Error
  end
  
  class Error::NotAcceptable < Error
  end
  
  class Error::Conflict < Error
  end
  
end