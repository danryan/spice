module Spice
  class DataBag < Spice::Chef
    attr_accessor :name, :public_key

    def self.all
      connection.get("/data")
    end
    
    
  end
end