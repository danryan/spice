require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Spice" do
  describe ".default_server_url" do
    it "should default to 'http://localhost:4000'" do
      Spice.default_server_url.should == "http://localhost:4000"
    end
    it "should not be settable" do
      lambda { Spice.default_server_url = "chef.example.com" }.should raise_error
    end
  end
  
  describe ".default_chef_version" do
    it "should default to '0.10.4'" do
      Spice.default_chef_version.should == "0.10.4"
    end
    it "should not be settable" do
      lambda { Spice.default_chef_version = "0.9.12" }.should raise_error
    end
  end
    
  describe ".server_url" do
    it "should default to 'localhost' if not set" do
      Spice.server_url.should == "http://localhost:4000"
    end
    it "should be settable" do
      Spice.server_url = "https://chef.example.com:4000"
      Spice.server_url.should == "https://chef.example.com:4000"
    end
  end
  
  describe ".chef_version" do
    it "should default to '0.10.4' if not set" do
      Spice.chef_version.should == "0.10.4"
    end
    it "should be settable" do
      Spice.chef_version = "0.9.12"
      Spice.chef_version.should == "0.9.12"
    end
  end
  
  describe ".client_name" do
    before { Spice.reset! }
    it "should not have a default" do
      Spice.client_name.should be_nil
    end
    it "should be settable" do
      Spice.client_name = "testclient"
      Spice.client_name.should == "testclient"
    end
  end
  
  describe ".key_file" do
    before { Spice.reset! }
    
    it "should not have a default" do
      Spice.key_file.should be_nil
    end
    it "should be settable" do
      Spice.key_file = "/tmp/keyfile.pem"
      Spice.key_file.should == "/tmp/keyfile.pem"
    end
    it "should raise exception if it does not exist" do
      lambda { Spice.key_file = "/tmp/badkey.pem" }.should raise_error(Errno::ENOENT)
    end
  end
  
  describe ".connection" do
    before { Spice.reset! }
    
    it "should not have a default" do
      Spice.connection.should be_nil
    end
  end
  
  
  describe ".reset!" do
    before do 
      Spice.server_url = "chef.example.com"
      Spice.key_file = "/tmp/keyfile.pem"
      Spice.client_name = "testduder"
    end
    it "should reset Spice.server_url" do
      Spice.reset!
      Spice.server_url.should == "http://localhost:4000"
    end
    it "should reset Spice.chef_version" do
      Spice.reset!
      Spice.chef_version.should == "0.10.4"
    end
    it "should unset Spice.key_file" do
      Spice.reset!
      Spice.key_file.should be_nil
    end
    it "should unset Spice.connection" do
      Spice.reset!
      Spice.connection.should be_nil
    end
  end
  
  describe ".connect!" do
    it "should create a connection object" do
      Spice.connect!
      Spice.connection.should be_a_kind_of(Spice::Connection)
    end
    it "connection should contain a server_url" do
      Spice.connection.server_url.should == "http://localhost:4000"
    end
  end
  
  describe ".autoconfigure!" do
    it "should locate /etc/chef/client.rb and create a connection object" do
    end
    
    it "should locate ~/.chef/client.rb and create a connection object" do
    end
    
    it "should locate ~/.chef/knife.rb and create a connection object" do
    end
  end
end
