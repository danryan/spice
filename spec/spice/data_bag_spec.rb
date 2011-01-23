require 'spec_helper'

module Spice
  describe DataBag do
    describe ".all" do
      before { setup_chef_client }

      it "returns a list of data_bags" do
        stub_data_bag_list
        DataBag.all.should == data_bag_list_response
      end
    end

    describe ".show" do
      before { setup_chef_client }

      context "if the data bag is found" do
        let(:response) { DataBag.show(:name => "users") }
        before do
          stub_data_bag_show
        end
        it "returns a valid data_bag" do
          response.should == data_bag_show_response
        end
      end
      
      context "if the data bag is not found" do
        let(:response) { DataBag.show(:name => "users") }
        before do
          stub_data_bag_show(404)
        end
        it "returns a 404 error" do
          puts response.response
          response.status.should == 404
        end
      end
          
    end
  #     
  #     context "errors" do
  #       it "return a 404 when a data_bag is not found" do
  #         stub_data_bag_show("applesauce", 404)
  #         lambda { DataBag.show(:name => "applesauce") }.
  #           should raise_error(RestDataBag::ResourceNotFound)
  #       end
  #       
  #       it "raises ArgumentError if option :name not present" do
  #         stub_data_bag_show("pizza")
  #         lambda {DataBag.show() }.should raise_error ArgumentError
  #       end
  #     end
  #   end
  # 
  #   describe ".create" do
  #     before { setup_chef_client }
  # 
  #     context "valid" do
  #       it "creates a valid non-admin data_bag" do
  #         stub_data_bag_create("spork")
  #         data_bag = DataBag.create(:name => "spork", :admin => false)
  #         data_bag["private_key"].should == "RSA PRIVATE KEY"
  #         data_bag["uri"].should == "http://http://localhost:4000/data_bags/spork"
  #       end
  #       
  #       it "creates a valid admin data_bag" do
  #         stub_data_bag_create("pants", true)
  #         response = DataBag.create(:name => "pants", :admin => true)
  #         response["private_key"].should == "RSA PRIVATE KEY"
  #         response["uri"].should == "http://http://localhost:4000/data_bags/pants"
  # 
  #         stub_data_bag_show("pants")
  #         data_bag = DataBag.show(:name => "pants")
  #         data_bag["admin"].should == true
  #       end
  #     end
  #     
  #     context "errors" do
  #       it "does not create a data_bag that already exists" do
  #         stub_data_bag_create("pants", false, 409)
  #         lambda { DataBag.create(:name => "pants", :admin => false) }.
  #           should raise_error(RestDataBag::Conflict)
  #       end
  #     end
  #   end
  # 
  #   describe ".update" do
  #     before { setup_chef_client }
  # 
  #     context "valid" do
  #       it "makes a data_bag an admin" do
  #         stub_data_bag_update("awesome", true, false, 200)
  #         DataBag.update(:name => "awesome", :admin => true, :private_key => false)
  #       end
  #       
  #       it "regenerates the data_bag private key" do
  #         stub_data_bag_update("awesome", false, true, 200)
  #         DataBag.update(:name => "awesome", :admin => false, :private_key => true)
  #       end
  #     end
  #   end
  # 
  #   describe ".delete" do
  #     before { setup_chef_client }
  # 
  #     context "valid" do
  #       it "deletes a data_bag" do
  #         stub_data_bag_delete("spork")
  #         DataBag.delete(:name => "spork")
  #       end
  #     end
  #     
  #     context "errors" do
  #       it "raises ArgumentError if option :name not present" do
  #         stub_data_bag_delete("pizza")
  #         lambda {DataBag.delete }.should raise_error ArgumentError
  #       end
  #       
  #       it "does not delete a non-existent data_bag" do
  #         stub_data_bag_delete("spork", 404)
  #         lambda { DataBag.delete(:name => "spork") }.
  #           should raise_error(RestDataBag::ResourceNotFound)
  #       end
  #     end
  #   end
  end
end