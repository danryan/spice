require 'spec_helper'

module Spice
  describe DataBag do
    describe ".list" do
      VCR.use_cassette 'data/list', :record => :new_episodes do
        DataBag.list
      end
    end
    
    describe ".show" do
      VCR.use_cassette 'data/show', :record => :new_episodes do
        DataBag.show(:name => "testdata")
      end
    end
    
    describe ".create" do
      VCR.use_cassette 'data/create', :record => :new_episodes do
        DataBag.create(:name => "testdata")
      end
    end
    
    describe ".update" do
      VCR.use_cassette 'data/update', :record => :new_episodes do
        DataBag.update(:name => "testdata")
      end
    end
    
    describe ".delete" do
      VCR.use_cassette 'data/delete', :record => :new_episodes do
        DataBag.delete(:name => "testdata")
      end
    end
  end
end