require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Spice" do
  context ".default_host" do
    it "should default to 'localhost'" do
      Spice.default_host.should == "localhost"
    end
    it "should not be settable" do
      lambda { Spice.default_host = "chef.example.com" }.should raise_error
    end
    # @default_host || "localhost"
  end
  
  context ".default_port" do
    it "should default to '4000'" do
      Spice.default_port.should == "4000"
    end
    it "should not be settable" do
      lambda { Spice.default_port = "9000" }.should raise_error
    end
  end
  
  context ".default_scheme" do
    it "should default to 'http'" do
      Spice.default_scheme.should == "http"
    end
    it "should not be settable" do
      lambda { Spice.default_scheme = "ftp" }.should raise_error
    end
  end
  
  context ".host" do
    it "should default to 'localhost' if not set" do
      Spice.host.should == "localhost"
    end
    it "should be settable" do
      Spice.host = "chef.example.com"
      Spice.host.should == "chef.example.com"
    end
  end
  
  context ".port" do
    it "should default to '4000' if not set" do
      Spice.port.should == "4000"
    end
    it "should be settable" do
      Spice.port = "9000"
      Spice.port.should == "9000"
    end
  end
  
  context ".scheme" do
    it "should default to 'http' if not set" do
      Spice.scheme.should == "http"
    end
    it "should be settable" do
      Spice.scheme = 'https'
      Spice.scheme.should == 'https'
    end
  end
  
  context ".client_name" do
    it "should not have a default" do
      Spice.client_name.should be_nil
    end
    it "should be settable" do
      Spice.client_name = "testclient"
      Spice.client_name.should == "testclient"
    end
  end
  
  context ".key_file" do
    it "should not have a default" do
      Spice.key_file.should be_nil
    end
    it "should be settable" do
      Spice.key_file = "/tmp/keyfile.pem"
      Spice.key_file.should == File.read("/tmp/keyfile.pem")
    end
    it "should raise exception if it does not exist" do
      lambda { Spice.key_file = "/tmp/badkey.pem" }.should raise_error(Errno::ENOENT)
    end
  end
  
  context ".connection" do
    it "should not have a default" do
      Spice.connection.should be_nil
    end
  end
  
  context ".reset!" do
    before do 
      Spice.host = "chef.example.com"
      Spice.port = "9000"
      Spice.scheme = "https"
      Spice.key_file = "/tmp/keyfile.pem"
      Spice.client_name = "testduder"
    end
    it "should reset Spice.host" do
      Spice.reset!
      Spice.host.should == "localhost"
    end
    it "should reset Spice.port" do
      Spice.reset!
      Spice.port.should == "4000"
    end
    it "should reset Spice.scheme" do
      Spice.reset!
      Spice.scheme.should == "http"
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
  context ".connect!" do
    it "should create a connection object" do
      Spice.connect!
      Spice.connection.should be_a_kind_of(Spice::Connection)
    end
    it "connection should contain a host" do
      Spice.connection.host.should == "localhost"
    end
  end
end
