require 'spec_helper'

module Spice
  describe Node do
    describe ".all" do
      before { stub_node_list }
      subject { Node.all }

      it { should have_body(node_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".show" do
      context "if the node is found" do
        before { stub_node_show }
        subject { Node.show(:name => "testnode") }
    
        it { should have_body(node_show_response) }
        it { should respond_with(200) } 
      end
      
      context "if the node is not found" do
        before { stub_node_show(404) }
        subject { Node.show(:name => "testnode") }
        
        it { should_not have_body(node_show_response) }
        it { should respond_with(404) }
      end
    end
    
    describe ".create" do
      context "if the node can be created" do
        before { stub_node_create }
        subject { Node.create(:name => "testnode") }
        
        it { should have_body(node_create_response) }
        it { should respond_with(201) }
      end
      
      context "if the node has a run list" do
        before { stub_node_create_with_run_list }
        subject do
          Node.create(
            :name => "testnode", 
            :run_list => ["recipe[unicorn]" ]
          )
        end
        
        it { should have_body(node_create_response_with_run_list) }
        it { should respond_with(201) }
      end
      
      context "if the node already exists" do
        before { stub_node_create(409) }
        subject { Node.create(:name => "testnode") }
        
        it { should have_body(node_conflict) }
        it { should respond_with(409) }
      end      
    end
    
    describe ".delete" do
      context "if the node can be deleted" do
        before { stub_node_delete }
        subject { Node.delete(:name => "testnode") }
        
        it { should have_body(node_delete_response) }
        it { should respond_with(200) }
      end
    
      context "if the node cannot be deleted" do
        before { stub_node_delete(404) }
        subject { Node.delete(:name => "testnode") }
        
        it { should have_body(node_not_found) }
        it { should respond_with(404) }
      end
    end
     
  end
end