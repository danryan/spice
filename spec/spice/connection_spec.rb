require 'spec_helper'

describe Spice::Connection do
  let(:keys) { Spice::Config::VALID_OPTIONS_KEYS }
  
  after do
    Spice.reset
  end
  
  context "with module configuration" do
    before do
      Spice.setup do |s|
        keys.each do |key|
          s.send("#{key}=", key)
        end
      end
    end
    
    it "should inherit module configuration" do
      connection = Spice::Connection.new
      keys.each do |key|
        connection.send(key).should == key
      end
    end
  end
  
  context "with class configuration" do
    before do
      @configuration = {
        :user_agent => "Spice Fake User Agent",
        :server_url => "http://chef.example.com:4000",
        :chef_version => "0.9.18",
        :client_name => "admin",
        :client_key => Spice.read_key_file(fake_key),
        :connection_options => { :timeout => 10 },
        :middleware => Proc.new {}
      }
    end
    
    context "during initialization" do
      it "should override module configuration" do
        connection = Spice::Connection.new(@configuration)
        keys.each do |key|
          connection.send(key).should == @configuration[key]
        end
      end
    end
    
    context "after initialization" do
      it "should override module configuration after initialization" do
        connection = Spice::Connection.new
        @configuration.each do |key, value|
          connection.send("#{key}=", value)
        end
        keys.each do |key|
          connection.send(key).should == @configuration[key]
        end
      end
      
    end
  end
    
end