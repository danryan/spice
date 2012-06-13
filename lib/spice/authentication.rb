require 'openssl'
# require 'mixlib/authentication'
require 'mixlib/authentication/signedheaderauth'

module Spice
  module Authentication
    
    def signature_headers(method, path, json_body=nil)
      uri = URI(server_url)
      
      params = {
        :http_method => method, 
        :path        => path,
        :body        => json_body || "", 
        :host        => "#{uri.host}:#{uri.port}",
        :timestamp   => Time.now.utc.iso8601,
        :user_id     => client_name
      }

      signing_object = Mixlib::Authentication::SignedHeaderAuth.signing_object(params)
      signed_headers = signing_object.sign(client_key)

      # Platform requires X-Chef-Version header
      signed_headers['X-Chef-Version'] = chef_version
      # signed_headers['Content-Length'] = json_body.bytesize.to_s if json_body
      signed_headers
    end # def signature_headers   
     
  end # module Authentication
end # module Spice
