require 'spec_helper'

module Spice
  describe Role do
    describe ".all" do
      VCR.use_cassette 'role/list', :record => :new_episodes do
        Role.list
      end
    end
    
    describe ".show" do
      VCR.use_cassette 'role/show', :record => :new_episodes do
        Role.show(:name => "testrole")
      end
    end
    
    describe ".create" do
      VCR.use_cassette 'role/create', :record => :new_episodes do
        Role.create(:name => "testrole")
      end
    end
    
    describe ".update" do
      VCR.use_cassette 'role/update', :record => :new_episodes do
        Role.update(:name => "testrole")
      end
    end
    
    describe ".delete" do
      VCR.use_cassette 'role/delete', :record => :new_episodes do
        Role.delete(:name => "testrole")
      end
    end
  end
end