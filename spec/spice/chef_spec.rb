require 'spec_helper'

module Spice
  describe Chef do
    describe '.connection' do
      before {  }
      it "returns an instance of Spice::Connection" do
        Spice::Chef.connection.should be_an_instance_of(Spice::Connection)
      end
    end
    
    describe ".clients" do
      before { stub_client_list }
      subject { Chef.clients }

      it { should have_body(client_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".cookbooks" do
      before { stub_cookbook_list }
      subject { Chef.cookbooks }

      it { should have_body(cookbook_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".data_bags" do
      before { stub_data_bag_list }
      subject { Chef.data_bags }

      it { should have_body(data_bag_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".nodes" do
      before { stub_node_list }
      subject { Chef.nodes }

      it { should have_body(node_list_response) }
      it { should respond_with(200) }
    end
    
    describe ".roles" do
      before { stub_role_list }
      subject { Chef.roles }

      it { should have_body(role_list_response) }
      it { should respond_with(200) }
    end

  end
end