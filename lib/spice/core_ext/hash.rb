module Spice
  module CoreExt
    module Hash

      def symbolize_keys!
        keys.each do |key|
          self[(key.to_sym rescue key) || key] = delete(key)
        end
        self
      end
      def symbolize_keys
        dup.symbolize_keys!
      end
      
    end
  end
end

class Hash
  include Spice::CoreExt::Hash
end