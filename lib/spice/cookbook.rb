module Spice
  class Cookbook < Spice::Chef
    attr_accessor :name, :public_key

    def self.all
      connection.get("/cookbooks")
    end
    
    def self.find(name)
      connection.get("/cookbooks/#{name}")
    end
  end
end