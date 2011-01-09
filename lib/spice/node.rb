module Spice
  class Node < Spice::Chef
    attr_accessor :name, :public_key

    def self.all
      connection.get("/nodes")
    end
    def self.find(name)
      connection.get("/nodes/#{name}")
    end
  end
end