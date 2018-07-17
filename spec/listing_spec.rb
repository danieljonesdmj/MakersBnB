require "listing"

describe Listing do

  describe ".create" do
    it "creates a listing" do
      Listing.create("name")
      expect(Listing.all).to include("name")
    end
  end

end
