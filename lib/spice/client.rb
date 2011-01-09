module Spice
  class Client < Spice::Chef
    attr_accessor :name, :public_key

    def self.all
      connection.get("/clients")
    end
    
    
  end
end