require 'spec_helper'

module Spice
  describe Node do
    context ".list" do
      VCR.use_cassette 'node/list', :record => :new_episodes do
        Node.list
      end
    end
    
    context ".show" do
      VCR.use_cassette 'node/show', :record => :new_episodes do
        Node.show(:name => "testnode")
      end
    end
    
    context ".create" do
      VCR.use_cassette 'node/create', :record => :new_episodes do
        Node.create(:name => "testnode")
      end
    end
    
    context ".update" do
      VCR.use_cassette 'node/update', :record => :new_episodes do
        Node.update(:name => "testnode")
      end
    end
    
    context ".delete" do
      VCR.use_cassette 'node/delete', :record => :new_episodes do
        Node.delete(:name => "testnode")
      end
    end
  end
end