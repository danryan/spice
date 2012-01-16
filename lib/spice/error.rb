module Spice
  class Error < StandardError
    attr_reader :http_headers
    
    def initialize(message, http_headers)
      @http_headers = Hash[http_headers]
      super(message)
    end
    
  end
  
  class BadRequest < Error
  end
  
  class Unauthorized < Error
  end
  
  class Forbidden < Error
  end
  
  class NotFound < Error
  end
  
  class NotAcceptable < Error
  end
  
  class Conflict < Error
  end
  
end