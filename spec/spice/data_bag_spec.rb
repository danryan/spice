require 'spec_helper'

module Spice
  describe DataBag do
    context ".list" do
      VCR.use_cassette 'data/list', :record => :new_episodes do
        DataBag.list
      end
    end
    
    context ".show" do
      VCR.use_cassette 'data/show', :record => :new_episodes do
        DataBag.show(:name => "testdata")
      end
    end
    
    context ".create" do
      VCR.use_cassette 'data/create', :record => :new_episodes do
        DataBag.create(:name => "testdata")
      end
    end
    
    context ".update" do
      VCR.use_cassette 'data/update', :record => :new_episodes do
        DataBag.update(:name => "testdata")
      end
    end
    
    context ".delete" do
      VCR.use_cassette 'data/delete', :record => :new_episodes do
        DataBag.delete(:name => "testdata")
      end
    end
  end
end