module Adapter
  module RestClient
    
    def exists?()
      client.get
    end
    
    def read(key)
      
    end
    
    def write(key)
      
    end
    
    def delete(key)
      
    end
    
    
    def clear
      true
    end
    
    def encode(value)
      value
    end
    
    def decode(value)
      value
    end
    
  end
end

Adapter.define(:rest_client, Adapter::RestClient)