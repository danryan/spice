require 'spec_helper'

module Spice
  describe Environment do
    describe ".all" do
      before { stub_environment_list }
      subject { Environment.all }

      it { should have_body(environment_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".show" do
      context "if the environment is found" do
        before { stub_environment_show }
        subject { Environment.show(:name => "dev") }
    
        it { should have_body(environment_show_response) }
        it { should respond_with(200) } 
      end
      
      context "if the environment is not found" do
        before { stub_environment_show(404) }
        subject { Environment.show(:name => "dev") }
        
        it { should_not have_body(environment_show_response) }
        it { should respond_with(404) }
      end
    end
    
    describe ".create" do
      context "if the environment can be created" do
        before { stub_environment_create }
        subject { Environment.create(:name => "dev") }
        
        it { should have_body(environment_create_response) }
        it { should respond_with(201) }
      end
      
      context "if the environment already exists" do
        before { stub_environment_create(409) }
        subject { Environment.create(:name => "dev") }
        
        it { should have_body(environment_conflict) }
        it { should respond_with(409) }
      end      
    end
    
    describe ".delete" do
      context "if the environment can be deleted" do
        before { stub_environment_delete }
        subject { Environment.delete(:name => "dev") }
        
        it { should have_body(environment_delete_response) }
        it { should respond_with(200) }
      end
    
      context "if the environment cannot be deleted" do
        before { stub_environment_delete(404) }
        subject { Environment.delete(:name => "dev") }
        
        it { should have_body(environment_not_found) }
        it { should respond_with(404) }
      end
    end
    
    describe ".list_cookbooks" do
      context "if cookbooks exists" do
        before { stub_environment_cookbooks_list }
        subject { Environment.list_cookbooks(:name => "dev") }
        
        it { should have_body(environment_cookbooks_list_response) }
        it { should respond_with(200) }
      end
    end
     
    describe ".show_cookbook" do
      context "if the cookbook exists" do
        before { stub_environment_cookbook_show }
        subject { Environment.show_cookbook(:name => "dev", :cookbook => "apache") }
        
        it { should have_body(environment_cookbook_show_response) }
        it { should respond_with(200) }
      end
       
      context "if the cookbook does not exist" do
        before { stub_environment_cookbook_show(404) }
        subject { Environment.show_cookbook(:name => "dev", :cookbook => "apache") }
        
        it { should have_body(environment_not_found) }
        it { should respond_with(404) }
      end
    end
     
  end
end