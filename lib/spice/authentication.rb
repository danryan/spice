require 'openssl'
require 'mixlib/authentication/signedheaderauth'

module Spice
  class Authentication
    attr_reader :key_file, :client_name, :key, :raw_key
    
    def initialize(client_name=nil, key_file=nil)
      @client_name, @key_file = client_name, key_file
      load_signing_key if sign_requests?
    end
    
    def sign_requests?
      !!key_file
    end
        
    def signature_headers(request_params={})
      request_params             = request_params.dup
      request_params[:timestamp] = Time.now.utc.iso8601
      request_params[:user_id]   = client_name
      host = request_params.delete(:host) || "localhost"
      
      sign_obj = Mixlib::Authentication::SignedHeaderAuth.signing_object(request_params)
      signed = sign_obj.sign(key).merge({:host => host})
      signed.inject({}){|memo, kv| memo["#{kv[0].to_s.upcase}"] = kv[1];memo}
      # Platform requires X-Chef-Version header
      version = { "X-Chef-Version" => Spice.chef_version }
      signed.merge!(version)      
    end
    
    private
    
    def load_signing_key
      begin
        @raw_key = File.read(key_file).strip
      rescue SystemCallError, IOError => e
        raise IOError, "Unable to read #{key_file}"
      end
      assert_valid_key_format!(@raw_key)
      @key = OpenSSL::PKey::RSA.new(@raw_key)
    end
    
    def assert_valid_key_format!(raw_key)
      unless (raw_key =~ /\A-----BEGIN RSA PRIVATE KEY-----$/) &&
         (raw_key =~ /^-----END RSA PRIVATE KEY-----\Z/)
        msg = "The file #{key_file} does not contain a correctly formatted private key.\n"
        msg << "The key file should begin with '-----BEGIN RSA PRIVATE KEY-----' and end with '-----END RSA PRIVATE KEY-----'"
        raise ArgumentError, msg
      end
    end
  end
end
