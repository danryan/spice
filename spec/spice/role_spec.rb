require 'spec_helper'

module Spice
  describe Role do
    describe ".all" do
      before { stub_role_list }
      subject { Role.all }

      it { should have_body(role_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".show" do
      context "if the role is found" do
        before { stub_role_show }
        subject { Role.show(:name => "testrole") }
    
        it { should have_body(role_show_response) }
        it { should respond_with(200) } 
      end
      
      context "if the role is not found" do
        before { stub_role_show(404) }
        subject { Role.show(:name => "testrole") }
        
        it { should_not have_body(role_show_response) }
        it { should respond_with(404) }
      end
    end
    
    describe ".create" do
      context "if the role can be created" do
        before { stub_role_create }
        subject { Role.create(:name => "testrole") }
        
        it { should have_body(role_create_response) }
        it { should respond_with(201) }
      end
      
      context "if the role already exists" do
        before { stub_role_create(409) }
        subject { Role.create(:name => "testrole") }
        
        it { should have_body(role_conflict) }
        it { should respond_with(409) }
      end      
    end
    
    describe ".delete" do
      context "if the role can be deleted" do
        before { stub_role_delete }
        subject { Role.delete(:name => "testrole") }
        
        it { should have_body(role_delete_response) }
        it { should respond_with(200) }
      end
    
      context "if the role cannot be deleted" do
        before { stub_role_delete(404) }
        subject { Role.delete(:name => "testrole") }
        
        it { should have_body(role_not_found) }
        it { should respond_with(404) }
      end
    end
     
  end
end