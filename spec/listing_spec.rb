require "listing"

describe Listing do

  describe ".create" do
    it "creates a listing" do
      subject.create("name")
      expect(subject.all).to include("name")
    end
  end
end