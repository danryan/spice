require 'spec_helper'

module Spice
  describe DataBag do
    describe ".all" do
      before { stub_data_bag_list }
      subject { DataBag.all }

      it { should have_body(data_bag_list_response) }
      it { should respond_with(200) }
    end

    describe ".show" do
      context "if the data bag is found" do
        before { stub_data_bag_show }
        subject { DataBag.show(:name => "users") }

        it { should have_body(data_bag_show_response) }
        it { should respond_with(200) } 
      end
      
      context "if the data bag is not found" do
        before { stub_data_bag_show(404) }
        subject { DataBag.show(:name => "users") }
        
        it { should_not have_body(data_bag_show_response) }
        it { should respond_with(404) }
      end
    end
    
    describe ".create" do
      context "if the data bag can be created" do
        before { stub_data_bag_create }
        subject { DataBag.create(:name => "users") }
        
        it { should have_body(data_bag_create_response) }
        it { should respond_with(201) }
      end
      
      context "if the data bag already exists" do
        before { stub_data_bag_create(409) }
        subject { DataBag.create(:name => "users") }
        
        it { should have_body(data_bag_conflict) }
        it { should respond_with(409) }
      end
    end

    describe ".delete" do
      context "if the data bag can be deleted" do
        before { stub_data_bag_delete }
        subject { DataBag.delete(:name => "users") }
        
        it { should have_body(data_bag_delete_response) }
        it { should respond_with(200) }
      end
    
      context "if the data bag cannot be deleted" do
        before { stub_data_bag_delete(404) }
        subject { DataBag.delete(:name => "users") }
        
        it { should have_body(data_bag_not_found) }
        it { should respond_with(404) }
      end
    end
  end
end