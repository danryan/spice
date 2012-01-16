require 'spice/persistence'

module Spice
  class Cookbook
    include Toy::Store
    include Spice::Persistence
    extend Spice::Persistence
    store :memory, {}
    endpoint "cookbooks"

    attribute :name, String
    attribute :versions, Array, :default => []

    validates_presence_of :name
  end
end