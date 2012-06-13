require 'spec_helper'

describe Spice::Connection do

  before do
    Spice.mock
  end
  
  after do
    Spice.reset
  end

  let(:connection) do
    Spice::Connection.new
  end
  
  describe "#clients" do
    before do
      stub_get("/search/client?q=%2A%3A%2A&sort=X_CHEF_id_CHEF_X+asc&start=0&rows=1000").
        # with(:query => { "q"=>"*:*", "sort"=>"X_CHEF_id_CHEF_X asc", "start"=>"0", "rows"=>"1000"}).
        to_return(:body => fixture('search/client.json'))
    end
    
    it "should return an array of clients" do
      clients = connection.clients
      clients.should be_an Array
    end
  end
  
  describe "#client" do
    before do
      stub_get("/clients/name").to_return(:body => fixture('clients/show.json'))
    end
    
    it "should return a single client" do
      client = connection.client("name")
      client.should be_a Spice::Client
      client.name.should == "monkeypants"
      client.admin.should == true
    end
  end
  
  describe "#update_client" do
    before do
      stub_put("/clients/name").
        with(:body => {:admin => false }).
        to_return(:body => fixture('clients/update.json'))
    end
    
    it "should update and return a single client" do
      client = connection.update_client("name", :admin => false)
      client.should be_a Spice::Client
      client.admin.should == false
    end
  end
  
  describe "#reregister_client" do
    before do
      stub_put("/clients/name").
        with(:body => { :private_key => true }).
        to_return(:body => fixture('clients/reregister.json'))
    end
    
    it "should update and return a single client with a new private key" do
      client = connection.reregister_client("name")
      client.should be_a Spice::Client
      client.private_key.should_not be_nil
    end
  end
  
  describe "#delete_client" do
    before do
      stub_delete("/clients/name")
    end
    
    it "should delete a client and return nil" do
      client = connection.delete_client("name")
      client.should be_nil
    end
  end
  
end