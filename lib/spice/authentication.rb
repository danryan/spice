require 'openssl'
# require 'mixlib/authentication'
require 'mixlib/authentication/signedheaderauth'

module Spice
  module Authentication
    
    def signature_headers(method, path, json_body=nil)
      uri = URI(Spice.server_url)
      
      params = {
        :http_method => method, 
        :path        => path,
        :body        => json_body || "", 
        :host        => "#{uri.host}:#{uri.port}",
        :timestamp   => Time.now.utc.iso8601,
        :user_id     => Spice.client_name
      }
      
      begin
        raw_key = File.read(Spice.key_file).strip      
      rescue SystemCallError, IOError => e
        raise IOError, "Unable to read #{key_file}"
      end
      
      unless (raw_key =~ /\A-----BEGIN RSA PRIVATE KEY-----$/) &&
         (raw_key =~ /^-----END RSA PRIVATE KEY-----\Z/)
        msg = "The file #{key_file} is not a properly formatted private key.\n"
        msg << "It must contain '-----BEGIN RSA PRIVATE KEY-----' and '-----END RSA PRIVATE KEY-----'"
        raise ArgumentError, msg
      end
      
      key = OpenSSL::PKey::RSA.new(raw_key)

      signing_object = Mixlib::Authentication::SignedHeaderAuth.signing_object(params)
      signed_headers = signing_object.sign(key)

      # Platform requires X-Chef-Version header
      signed_headers['X-Chef-Version'] = Spice.chef_version
      # signed_headers['Content-Length'] = json_body.bytesize.to_s if json_body
      signed_headers
    end # def signature_headers   
     
  end # module Authentication
end # module Spice
