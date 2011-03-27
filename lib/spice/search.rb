module Spice
  class Search < Spice::Chef
    INDEXES = %w(node role client users)
    
    INDEXES.each do |index|
      define_method index do |options|
        options ||= {}
        
        query = options[:q] || '*:*'
        sort = options[:sort] || "X_CHEF_id_CHEF_X asc"
        start = options[:start] || 0
        rows = options[:rows] || 1000
        
        connection.get("/search/#{index}?q=#{query}&sort=#{sort}&start=#{start}&rows=#{rows}")
      end
    end
  end
end
