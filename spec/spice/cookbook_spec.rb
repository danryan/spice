require 'spec_helper'

module Spice
  describe Cookbook do
    describe ".all" do
      before { stub_cookbook_list }
      subject { Cookbook.all }

      it { should have_body(cookbook_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".show" do
      context "if the cookbook is found" do
        before { stub_cookbook_show }
        subject { Cookbook.show(:name => "testcookbook") }
    
        it { should have_body(cookbook_show_response) }
        it { should respond_with(200) } 
      end
      
      context "if the cookbook is not found" do
        before { stub_cookbook_show(404) }
        subject { Cookbook.show(:name => "testcookbook") }
        
        it { should_not have_body(cookbook_show_response) }
        it { should respond_with(404) }
      end
    end
    
    describe ".create" do
      context "if the cookbook can be created" do
        before { stub_cookbook_create }
        subject { Cookbook.create(:name => "testcookbook") }
        
        it { should have_body(cookbook_create_response) }
        it { should respond_with(201) }
      end
      
      context "if the cookbook already exists" do
        before { stub_cookbook_create(409) }
        subject { Cookbook.create(:name => "testcookbook") }
        
        it { should have_body(cookbook_conflict) }
        it { should respond_with(409) }
      end      
    end
    
    describe ".delete" do
      context "if the cookbook can be deleted" do
        before { stub_cookbook_delete }
        subject { Cookbook.delete(:name => "testcookbook") }
        
        it { should have_body(cookbook_delete_response) }
        it { should respond_with(200) }
      end
    
      context "if the cookbook cannot be deleted" do
        before { stub_cookbook_delete(404) }
        subject { Cookbook.delete(:name => "testcookbook") }
        
        it { should have_body(cookbook_not_found) }
        it { should respond_with(404) }
      end
    end
     
  end
end