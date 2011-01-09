module Spice
  class DataBag < Spice::Chef
    attr_accessor :name, :public_key

    def self.all
      connection.get("/data")
    end
    
    def self.find(name)
      connection.get("/data/#{name}")
    end
  end
end