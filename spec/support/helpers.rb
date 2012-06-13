# encoding: utf-8
# unless ENV['CI']
#   require 'simplecov'
#   SimpleCov.start do
#     add_filter 'spec'
#   end
# end

require 'spice'
require 'rspec'
require 'timecop'
require 'webmock/rspec'

def a_delete(path, server_url=Spice.server_url)
  a_request(:delete, server_url + path)
end

def a_get(path, server_url=Spice.server_url)
  a_request(:get, server_url + path)
end

def a_post(path, server_url=Spice.server_url)
  a_request(:post, server_url + path)
end

def a_put(path, server_url=Spice.server_url)
  a_request(:put, server_url + path)
end

def stub_delete(path, server_url=Spice.server_url)
  stub_request(:delete, server_url + path)
end

def stub_get(path, server_url=Spice.server_url)
  stub_request(:get, server_url + path)
end

def stub_post(path, server_url=Spice.server_url)
  stub_request(:post, server_url + path)
end

def stub_put(path, server_url=Spice.server_url)
  stub_request(:put, server_url + path)
end

def fixture_path
  File.expand_path("../../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def fake_key
  File.expand_path("../../fixtures/client.pem", __FILE__)
end

alias :fake_key_path :fake_key
