module Spice
  class Client
    attr_reader :name
    def initialize(name)
      @name = name
    end
    
    def to_s
      name
    end
  end
end