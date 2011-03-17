require 'spec_helper'

module Spice
  describe Cookbook do
    describe ".all" do

      it "returns a list of cookbooks" do
        stub_cookbook_list
        Cookbook.all.length.should == 1
      end
    end

    describe ".show" do
      
      context "valid" do
        it "returns a valid cookbook" do
          stub_cookbook_show("monkeypants")
          cookbook = Cookbook.show(:name => "monkeypants")
          cookbook["name"].should == "monkeypants"
          cookbook["admin"].should == true
        end
      end
      
      context "errors" do
        it "return a 404 when a cookbook is not found" do
          stub_cookbook_show("applesauce", 404)
          lambda { Cookbook.show(:name => "applesauce") }.
            should raise_error(RestCookbook::ResourceNotFound)
        end
        
        it "raises ArgumentError if option :name not present" do
          stub_cookbook_show("pizza")
          lambda {Cookbook.show() }.should raise_error ArgumentError
        end
      end
    end

    describe ".create" do

      context "valid" do
        it "creates a valid non-admin cookbook" do
          stub_cookbook_create("spork")
          cookbook = Cookbook.create(:name => "spork", :admin => false)
          cookbook["private_key"].should == "RSA PRIVATE KEY"
          cookbook["uri"].should == "http://http://localhost:4000/cookbooks/spork"
        end
        
        it "creates a valid admin cookbook" do
          stub_cookbook_create("pants", true)
          response = Cookbook.create(:name => "pants", :admin => true)
          response["private_key"].should == "RSA PRIVATE KEY"
          response["uri"].should == "http://http://localhost:4000/cookbooks/pants"

          stub_cookbook_show("pants")
          cookbook = Cookbook.show(:name => "pants")
          cookbook["admin"].should == true
        end
      end
      
      context "errors" do
        it "does not create a cookbook that already exists" do
          stub_cookbook_create("pants", false, 409)
          lambda { Cookbook.create(:name => "pants", :admin => false) }.
            should raise_error(RestCookbook::Conflict)
        end
      end
    end

    describe ".update" do

      context "valid" do
        it "makes a cookbook an admin" do
          stub_cookbook_update("awesome", true, false, 200)
          Cookbook.update(:name => "awesome", :admin => true, :private_key => false)
        end
        
        it "regenerates the cookbook private key" do
          stub_cookbook_update("awesome", false, true, 200)
          Cookbook.update(:name => "awesome", :admin => false, :private_key => true)
        end
      end
    end

    describe ".delete" do

      context "valid" do
        it "deletes a cookbook" do
          stub_cookbook_delete("spork")
          Cookbook.delete(:name => "spork")
        end
      end
      
      context "errors" do
        it "raises ArgumentError if option :name not present" do
          stub_cookbook_delete("pizza")
          lambda {Cookbook.delete }.should raise_error ArgumentError
        end
        
        it "does not delete a non-existent cookbook" do
          stub_cookbook_delete("spork", 404)
          lambda { Cookbook.delete(:name => "spork") }.
            should raise_error(RestCookbook::ResourceNotFound)
        end
      end
    end
  end
end