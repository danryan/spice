require 'cgi'

module Spice
  class Connection
    module Search
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
          get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |node|
            Spice::Node.new(node)
          end
        when 'role'
          get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |role|
            Spice::Role.new(role)
          end
        when 'client'
          get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |client|
            Spice::Client.new(client)
          end
        when 'environment'
          get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |env|
            env['attrs'] = env.delete('attributes')
            Spice::Environment.new(env)
          end
        else
          # assume it's a data bag
          get("/search/#{CGI::escape(index.to_s)}?#{params}").body['rows'].map do |db|
            data = db['raw_data']
            id = data.delete('id')
            Spice::DataBagItem.new(:_id => id, :data => data)
          end
        end
      end # def search
      
    end # module Search
  end # class Connection
end # module Spice