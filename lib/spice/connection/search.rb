require 'cgi'

module Spice
  class Connection
    module Search
      # @option options [String] :q The Solr search query string
      # @option options [String] :sort Order by which to sort the results
      # @option options [Numeric] :start The number by which to offset the results
      # @option options [Numeric] :rows The maximum number of rows to return
      def search(index, options={})
        options = {:q => options} if options.is_a? String
        options.symbolize_keys!

        options[:q] ||= '*:*'
        options[:sort] ||= "X_CHEF_id_CHEF_X asc"
        options[:start] ||= 0
        options[:rows] ||= 1000

        # clean up options hash
        options.delete_if{|k,v| !%w(q sort start rows).include?(k.to_s)}

        params = options.collect{ |k, v| "#{k}=#{CGI::escape(v.to_s)}"}.join("&")
        case index
        when 'node'
          connection.get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |node|
            Spice::Node.new(node)
          end
        when 'role'
          connection.get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |role|
            Spice::Role.new(role)
          end
        when 'client'
          connection.get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |client|
            Spice::Client.new(client)
          end
        when 'environment'
          connection.get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |env|
            env['attrs'] = env.delete('attributes')
            Spice::Environment.new(env)
          end
        else
          # assume it's a data bag
          connection.get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |db|
            data = db['raw_data']
            id = data.delete('id')
            Spice::DataBagItem.new(:_id => id, :data => data, :name => index)
          end
        end
      end # def search
      
    end # module Search
  end # class Connection
end # module Spice