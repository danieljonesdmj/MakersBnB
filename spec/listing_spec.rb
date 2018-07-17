require "listing"

describe Listing do

  describe ".create" do
    it "creates a listing" do
      Listing.create("name")
      expect(Listing.all).to include("name")
    end
  end

  describe ".request" do
    it "sends a request to the owner" do
      Listing.request("name")
      expect(Listing.request).to  #Incomplete
    end
  end
end
