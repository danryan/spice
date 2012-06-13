require 'spec_helper'

module Spice
  describe Config do
    describe ".default values" do
      it 'should have default values' do
        Spice::Config::DEFAULT_SERVER_URL.should == "http://localhost:4000"
        Spice::Config::DEFAULT_CHEF_VERSION.should == "0.10.10"
        Spice::Config::DEFAULT_USER_AGENT.should == "Spice #{Spice::VERSION}"
        Spice::Config::DEFAULT_CONNECTION_OPTIONS.should == {}
      end
    end
  end
end