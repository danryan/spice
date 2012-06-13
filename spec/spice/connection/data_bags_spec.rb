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
  
  describe "#data_bags" do
    before do
      stub_get("/search/users?q=%2A%3A%2A&sort=X_CHEF_id_CHEF_X+asc&start=0&rows=1000").
        to_return(:body => fixture('search/data_bag.json'))
      stub_get("/data").
        to_return(:body => fixture('data_bags/index.json'))
    end
    
    it "should return an array of data bags" do
      data_bags = connection.data_bags
      data_bags.should be_an Array
      data_bags.first.should be_a Spice::DataBag
      # puts data_bags.first.inspect
      data_bags.first.name.should == "users"
      data_bags.first.items.should be_an Array
      data_bags.first.items.first.should be_a Spice::DataBagItem
      data_bags.first.items.first.id.should == "adam"
      data_bags.first.items.first.real_name.should == "Adam Jacob"
      # data_bags.first.items.first.should respond_to(:real_name)
      # data_bags.first.items.first.should_not respond_to(:bad_method)
    end
  end
  
  describe "#data_bag" do
    before do
      stub_get("/search/users?q=%2A%3A%2A&sort=X_CHEF_id_CHEF_X+asc&start=0&rows=1000").
        to_return(:body => fixture('search/data_bag.json'))
      stub_get("/data/users").to_return(:body => fixture('data_bags/show.json'))
    end
    
    it "should return a single data bag" do
      data_bag = connection.data_bag("users")
      data_bag.should be_a Spice::DataBag
      data_bag.name.should == "users"
      data_bag.items.first.should be_a Spice::DataBagItem
      data_bag.items.first.id.should == "adam"
      data_bag.items.first.real_name.should == "Adam Jacob"
    end
  end
  
  describe "#data_bag_item" do
    before do
      stub_get("/data/users/adam").
        to_return(:body => fixture('data_bags/show.json'))
    end
    
    it "should return a data bag item" do
      data_bag_item = connection.data_bag_item("users", "adam")
      data_bag_item.should be_a Spice::DataBagItem
    end
  end
  
  describe "#create_data_bag" do
    before do
      stub_post("/data").
        with(:body => { :name => "users"}).
        to_return(:body => fixture('data_bags/create.json'))
    end
    
    it "should create a client" do
      data_bag = connection.create_data_bag("users")
      data_bag.should be_a Spice::DataBag
      data_bag.name.should == "users"
      data_bag.items.should be_an Array
      data_bag.items.should be_empty
    end
  end
  
  describe "#create_data_bag_item" do
    before do
      stub_post("/data/users").
        with(:body => { :id => "adam", :real_name => "Adam Jacob" }).
        to_return(:body => fixture('data_bag_items/create.json'))
    end
    
    it "should create a data bag item and return it" do
      data_bag_item = connection.create_data_bag_item("users", :id => "adam", :real_name => "Adam Jacob")
      data_bag_item.should be_a Spice::DataBagItem
      data_bag_item.id.should == "adam"
      data_bag_item.real_name.should == "Adam Jacob"
    end
  end
  
  describe "#update_data_bag_item" do
    before do
      stub_put("/data/users/adam").
        with(:body => {:id => "adam", :real_name => "Adam Brent Jacob"} ).
        to_return(:body => fixture('data_bag_items/update.json'))
    end
    
    it "should update a data bag item and return it" do
      data_bag_item = connection.update_data_bag_item("users", "adam", :id => "adam", :real_name => "Adam Brent Jacob")
      data_bag_item.should be_a Spice::DataBagItem
      data_bag_item.id.should == "adam"
      data_bag_item.real_name.should == "Adam Brent Jacob"
    end
  end
  
  describe "#delete_data_bag_item" do
    before do
      stub_delete("/data/users/adam")
    end
    
    it "should delete a data bag item and return nil" do
      data_bag_item = connection.delete_data_bag_item("users", "adam")
      data_bag_item.should be_nil
    end
  end
  
end