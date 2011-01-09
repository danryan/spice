c = Spice::Connection.new("http://chef.int.canvashosting.com:4000", "dryan", "/Users/dan/.chef/dryan.pem")
c.get("/clients")

s = Spice::Chef.new(:host => "chef.int.canvashosting.com", :client_name => "dryan", :key_file => "/Users/dan/.chef/dryan.pem")