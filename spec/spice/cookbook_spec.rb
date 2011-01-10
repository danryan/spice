require 'spec_helper'

module Spice
  describe Cookbook do
    context ".list" do
      VCR.use_cassette 'cookbook/list', :record => :new_episodes do
        Cookbook.list
      end
    end
    
    context ".show" do
      VCR.use_cassette 'cookbook/show', :record => :new_episodes do
        Cookbook.show(:name => "testcookbook")
      end
    end
    
    context ".create" do
      VCR.use_cassette 'cookbook/create', :record => :new_episodes do
        Cookbook.create(:name => "testcookbook")
      end
    end
    
    context ".update" do
      VCR.use_cassette 'cookbook/update', :record => :new_episodes do
        Cookbook.update(:name => "testcookbook")
      end
    end
    
    context ".delete" do
      VCR.use_cassette 'cookbook/delete', :record => :new_episodes do
        Cookbook.delete(:name => "testcookbook")
      end
    end
  end
end