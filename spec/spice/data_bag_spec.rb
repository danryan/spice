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
    
    describe ".show_item" do
      context "if the data bag item exists" do
        before { stub_data_bag_item_show }
        subject { DataBag.show_item(:name => "users", :id => "adam") }
        
        it { should have_body(data_bag_item_show_response) }
        it { should respond_with(200) }
      end
      
      context "if the data bag item does not exist" do
        before { stub_data_bag_item_show(404) }
        subject { DataBag.show_item(:name => "users", :id => "adam") }
        
        it { should have_body(data_bag_item_not_found) }
        it { should respond_with(404) }
      end
    end
    
    describe ".create_item" do
      context "if the data bag item can be created" do
        before { stub_data_bag_item_create }
        subject do
          Spice::DataBag.create_item(
            :name => "users", :id => "adam", :real_name => "Adam Jacob"
          )
        end
        
        it { should have_body(data_bag_item_create_response) }
        it { should respond_with(201) }
      end
      
      context "if the data bag item cannot be created" do
        before { stub_data_bag_item_create(409) }
        subject do
          Spice::DataBag.create_item(
            :name => "users", :id => "adam", :real_name => "Adam Jacob"
          )
        end

        it { should have_body(data_bag_item_conflict) }
        it { should respond_with(409) }
      end
      
      context "if the data bag does not exist" do
        before { stub_data_bag_item_create(404) }
        subject do
          Spice::DataBag.create_item(
            :name => "users", :id => "adam", :real_name => "Adam Jacob"
          )
        end

        it { should have_body(data_bag_not_found) }
        it { should respond_with(404) }
      end
    end
    
    describe ".update_item" do
      context "if the data bag item can be updated" do
        before { stub_data_bag_item_update }
        subject do
          Spice::DataBag.update_item(
            :name => "users", :id => "adam", :title => "Supreme Awesomer"
          )
        end
        
        it { should have_body(data_bag_item_update_response) }
        it { should respond_with(200) }
      end
      
      context "if the data bag item cannot be updated" do
        before { stub_data_bag_item_update(404) }
        subject do 
          Spice::DataBag.update_item(
            :name => "users", :id => "adam", :title => "Supreme Awesomer"
          )
        end
        it { should have_body(data_bag_item_not_found) }
        it { should respond_with(404) }
      end
    end
    
    describe ".delete_item" do
      context "if the data bag item can be deleted" do
        before { stub_data_bag_item_delete }
        subject{ Spice::DataBag.delete_item(:name => "users", :id => "adam") }
        
        it { should have_body(data_bag_item_delete_response) }
        it { should respond_with(200) }
      end
      
      context "if the data bag item cannot be deleted" do
        before { stub_data_bag_item_delete(404) }
        subject{ Spice::DataBag.delete_item(:name => "users", :id => "adam") }
        
        it { should have_body(data_bag_item_not_found) }
        it { should respond_with(404) }
        
        
      end
    end
  end
end