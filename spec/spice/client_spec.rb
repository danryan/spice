require 'spec_helper'

module Spice
  describe Client do
    describe ".all" do
      before { stub_client_list }
      subject { Client.all }

      it { should have_body(client_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".show" do
      context "if the client is found" do
        before { stub_client_show }
        subject { Client.show(:name => "testclient") }
    
        it { should have_body(client_show_response) }
        it { should respond_with(200) } 
      end
      
      context "if the client is not found" do
        before { stub_client_show(404) }
        subject { Client.show(:name => "testclient") }
        
        it { should_not have_body(client_show_response) }
        it { should respond_with(404) }
      end
    end
    
    describe ".create" do
      context "if the client can be created" do
        before { stub_client_create }
        subject { Client.create(:name => "testclient") }
        
        it { should have_body(client_create_response) }
        it { should respond_with(201) }
      end
      
      context "if the client already exists" do
        before { stub_client_create(409) }
        subject { Client.create(:name => "testclient") }
        
        it { should have_body(client_conflict) }
        it { should respond_with(409) }
      end      
    end
    
    describe ".delete" do
      context "if the client can be deleted" do
        before { stub_client_delete }
        subject { Client.delete(:name => "testclient") }
        
        it { should have_body(client_delete_response) }
        it { should respond_with(200) }
      end
    
      context "if the client cannot be deleted" do
        before { stub_client_delete(404) }
        subject { Client.delete(:name => "testclient") }
        
        it { should have_body(client_not_found) }
        it { should respond_with(404) }
      end
    end
     
  end
end