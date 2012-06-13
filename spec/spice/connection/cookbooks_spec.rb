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
  
  describe "#cookbooks" do
    context "version 0.9.x" do
      before do
        Spice.chef_version = "0.9.18"
        stub_get("/cookbooks").
          to_return(:body => fixture('cookbooks/index-0.9.json'))
        stub_get("/cookbooks/unicorn").
          to_return(:body => fixture('cookbooks/show-unicorn-0.9.json'))
        stub_get("/cookbooks/apache2").
          to_return(:body => fixture('cookbooks/show-apache2-0.9.json'))
      end
      
      it "should return an array of clients" do
        cookbooks = connection.cookbooks
        cookbooks.should be_an Array
        cookbooks.first.should be_a Spice::Cookbook
        # cookbooks.first.name.should == "unicorn"
      end
    end
    
    context "version 0.10.x" do
      
      before do
        Spice.chef_version = "0.10.10"
        stub_get("/cookbooks").
          with(:query => { :num_versions => 'all' }).
          to_return(:body => fixture('cookbooks/index-0.10.json'))
      end
      
      it "should return an array of cookbooks" do
        cookbooks = connection.cookbooks
        cookbooks.should be_an Array
        cookbooks.first.should be_a Spice::Cookbook
        # cookbooks.first.name.should == "apache2"
      end
    end
  end
  
  describe "#cookbook" do
    context "version 0.9.x" do
      before do
        Spice.chef_version = "0.9.18"
        stub_get("/cookbooks/unicorn").
          to_return(:body => fixture('cookbooks/show-unicorn-0.9.json'))
      end
      
      it "should return a single cookbook" do
        cookbook = connection.cookbook("unicorn")
        cookbook.should be_a Spice::Cookbook
        cookbook.name.should == "unicorn"
      end
    end
    
    context "version 0.10.x" do
      before do
        Spice.chef_version = "0.10.10"
        stub_get("/cookbooks/apache2").
          to_return(:body => fixture('cookbooks/show-0.10.json'))
      end
      
      it "should return a single cookbook" do
        cookbook = connection.cookbook("apache2")
        cookbook.should be_a Spice::Cookbook
        cookbook.name.should == "apache2"
      end
    end   

  end
  
end