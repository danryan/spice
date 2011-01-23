require 'spec_helper'

module Spice
  describe Client do
    describe ".all" do
      before { setup_chef_client }

      it "returns a list of clients" do
        stub_client_list
        Client.all.length.should == 1
      end
    end

    describe ".show" do
      before { setup_chef_client }
      
      context "valid" do
        it "returns a valid client" do
          stub_client_show("monkeypants")
          client = Client.show(:name => "monkeypants")
          client["name"].should == "monkeypants"
          client["admin"].should == true
        end
      end
      
      context "errors" do
        it "return a 404 when a client is not found" do
          stub_client_show("applesauce", 404)
          lambda { Client.show(:name => "applesauce") }.
            should raise_error(RestClient::ResourceNotFound)
        end
        
        it "raises ArgumentError if option :name not present" do
          stub_client_show("pizza")
          lambda {Client.show() }.should raise_error ArgumentError
        end
      end
    end

    describe ".create" do
      before { setup_chef_client }

      context "valid" do
        it "creates a valid non-admin client" do
          stub_client_create("spork")
          client = Client.create(:name => "spork", :admin => false)
          client["private_key"].should == "RSA PRIVATE KEY"
          client["uri"].should == "http://http://localhost:4000/clients/spork"
        end
        
        it "creates a valid admin client" do
          stub_client_create("pants", true)
          response = Client.create(:name => "pants", :admin => true)
          response["private_key"].should == "RSA PRIVATE KEY"
          response["uri"].should == "http://http://localhost:4000/clients/pants"

          stub_client_show("pants")
          client = Client.show(:name => "pants")
          client["admin"].should == true
        end
      end
      
      context "errors" do
        it "does not create a client that already exists" do
          stub_client_create("pants", false, 409)
          lambda { Client.create(:name => "pants", :admin => false) }.
            should raise_error(RestClient::Conflict)
        end
      end
    end

    describe ".update" do
      before { setup_chef_client }

      context "valid" do
        it "makes a client an admin" do
          stub_client_update("awesome", true, false, 200)
          Client.update(:name => "awesome", :admin => true, :private_key => false)
        end
        
        it "regenerates the client private key" do
          stub_client_update("awesome", false, true, 200)
          Client.update(:name => "awesome", :admin => false, :private_key => true)
        end
      end
    end

    describe ".delete" do
      before { setup_chef_client }

      context "valid" do
        it "deletes a client" do
          stub_client_delete("spork")
          Client.delete(:name => "spork")
        end
      end
      
      context "errors" do
        it "raises ArgumentError if option :name not present" do
          stub_client_delete("pizza")
          lambda {Client.delete }.should raise_error ArgumentError
        end
        
        it "does not delete a non-existent client" do
          stub_client_delete("spork", 404)
          lambda { Client.delete(:name => "spork") }.
            should raise_error(RestClient::ResourceNotFound)
        end
      end
    end
  end
end