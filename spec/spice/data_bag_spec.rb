require 'spec_helper'

module Spice
  describe DataBag do
    describe ".all" do
      DataBag.list
    end

    describe ".show" do
      DataBag.show(:name => "testdata")
    end

    describe ".create" do
      DataBag.create(:name => "testdata")
    end

    describe ".update" do
      DataBag.update(:name => "testdata")
    end

    describe ".delete" do
      DataBag.delete(:name => "testdata")
    end
  end
end