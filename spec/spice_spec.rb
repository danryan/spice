require 'spec_helper'

describe Spice do
  after do
    Spice.reset
  end
  
  describe '.new' do
    it "returns a Spice::Connection" do
      Spice.new.should be_a Spice::Connection
    end
  end
end