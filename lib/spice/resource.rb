module Spice
  class Resource
   
   def connection
     @connection ||= Connection.new()
  end
end