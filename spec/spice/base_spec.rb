require 'spec_helper'

describe Spice::Base do
  let(:base) { Spice::Base.new(:id => 1) }
  
  describe "#[]" do
    it "should be able to call methods using [] with a symbol" do
      base[:object_id].should be_an Integer
    end
    
    it "should be able to call methods using [] with a string" do
      base['object_id'].should be_an Integer
    end
    
    it "should return nil for missing methods" do
      base[:foo].should be_nil
      base['foo'].should be_nil
    end
  end
  
  describe "#to_hash" do
    it "should return a hash" do
      base.to_hash.should be_a Hash
      base.to_hash['id'].should == 1
    end
  end
  
  describe "identical objects" do
    it "should have the same object_id" do
      base.object_id.should == Spice::Base.get('id' => 1).object_id
    end
  end
  
end
