require 'rest-client'
require 'mixlib/authentication'
require 'yajl'
require 'cgi'

require 'spice/authentication'
require 'spice/chef'

require 'spice/core_ext/hash'

require 'spice/role'
require 'spice/client'
require 'spice/cookbook'
require 'spice/data_bag'
require 'spice/node'
require 'spice/search'
require 'spice/connection'

require 'spice/version'
require 'spice/mock'

module Spice

  class << self
    attr_writer :host, :port, :scheme, :url_path, :client_name, :connection, :key_file, :raw_key

    def default_host
      @default_host || "localhost"
    end

    def default_port
      @default_port || "4000"
    end

    def default_scheme
      @default_scheme || "http"
    end

    def default_url_path
      @default_url_path || ""
    end

    def host
      @host || default_host
    end

    def port
      @port || default_port
    end

    def scheme
      @scheme || default_scheme
    end

    def client_name
      @client_name
    end

    def key_file
      @key_file
    end

    def raw_key
      @raw_key
    end

    def key_file=(new_key_file)
      raw_key = File.read(new_key_file)
      assert_valid_key_format!(raw_key)
      @key_file = new_key_file
      @raw_key = raw_key
    end


    def url_path
      @url_path || default_url_path
    end

    def connection
      @connection
    end

    def connect!
      @connection = Connection.new(
        :url => "#{scheme}://#{host}:#{port}/#{url_path}",
        :client_name => client_name,
        :key_file => key_file
      )
    end

    def reset!
      @host = default_host
      @port = default_port
      @scheme = default_scheme
      @key_file = nil
      @client_name = nil
      @connection = nil
    end

    def setup
      yield self
    end

    def mock
      Spice::Mock.setup_mock_client
    end

    private

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
