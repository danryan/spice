module Spice
  class Search < Spice::Chef
    def self.search(index, options={})
      options = {:q => options} if options.is_a? String
      options.symbolize_keys!

      options[:q] ||= '*:*'
      options[:sort] ||= "X_CHEF_id_CHEF_X asc"
      options[:start] ||= 0
      options[:rows] ||= 1000

      # clean up options hash
      options.delete_if{|k,v| !%w(q sort start rows).include?(k.to_s)}

      params = options.collect{ |k, v| "#{k}=#{CGI::escape(v.to_s)}"}.join("&")
      connection.get("/search/#{CGI::escape(index.to_s)}?#{params}")
    end

    def self.method_missing(*args, &block)
      self.search(*args, &block)
    end
  end
end
