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
      
      def deep_merge(hash)
        target = self.dup
        hash.keys.each do |key|
          if hash[key].is_a?(Hash) && self[key].is_a?(Hash)
            target[key] = target[key].deep_merge(hash[key])
            next
          end
          target[key] = hash[key]
        end
        target
      end
      
    end
  end
end

class Hash
  include Spice::CoreExt::Hash
end