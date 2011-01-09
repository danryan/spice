require 'yajl/json_gem'
require 'rest-client'

require 'spice/authentication'
require 'spice/chef'

require 'spice/client'
require 'spice/cookbook'
require 'spice/data_bag'
require 'spice/node'
require 'spice/connection'

require 'spice/options_hash'
require 'spice/criteria_hash'
require 'spice/query'

module Spice
  def self.authenticate!(options={})
    Spice::Chef.new(options={})
  end
  # Your code goes here...
end
