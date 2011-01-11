require 'spec_helper'

module Spice
  describe Client do
    describe ".list" do
      # setup_authentication
      let(:chef) { setup_chef_client }
      it "returns a list of clients" do
        VCR.use_cassette 'client/list', :record => :new_episodes do
          # chef.get_rest("/clients")
        end
      end
    end
    
    describe ".show" do
      # VCR.use_cassette 'client/show', :record => :new_episodes do
      #   Client.show(:name => "testclient")
      # end
      let(:chef) { setup_chef_client }
      it "returns a valid client" do
        VCR.use_cassette 'client/show', :record => :new_episodes do
          # chef.get_rest("/clients/admin")
        end
      end
      it "returns nothing when a client is not found" do
        VCR.use_cassette 'client/show_not_found', :record => :new_episodes do
          # chef.get_rest("/clients/badclient")
        end
      end
    end
    
    describe ".create" do
      let(:chef) { setup_chef_client }      
      it "creates a valid non-admin client" do
        VCR.use_cassette 'client/create_nonadmin', :record => :new_episodes do
          # chef.post_rest("/clients", JSON.generate(:name => "lkjasdf", :admin => false))
          Client.create(:name => "kijasf", :admin => false)
        end
      end
      # it "creates a valid admin client" do
      #         VCR.use_cassette 'client/create', :record => :new_episodes do
      #           chef.post_rest("/clients", JSON.parse(:name => "testclient", :admin => true))
      #         end
      #       end
      it "does not create a client that already exists"
    end
    #     
    #     describe ".update" do
    #       setup_authentication
    #       
    #       let(:name) { Forgery::Name.first_name.downcase.to_s }
    #       before { Client.create(:name => name) }
    #       VCR.use_cassette 'client/update', :record => :new_episodes do
    #         Client.update(:name => "name")
    #       end
    #     end
    #     
    #     describe ".delete" do
    #       setup_authentication
    #       
    #       let(:name) { Forgery::Name.first_name.downcase.to_s }
    #       before { Client.create(:name => name) }
    #       
    #       VCR.use_cassette 'client/delete', :record => :new_episodes do
    #         Client.delete(:name => name)
    #       end
    #     end
  end
end