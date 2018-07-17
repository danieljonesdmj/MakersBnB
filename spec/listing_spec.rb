require "listing"

describe Listing do

  describe ".create" do
    it "creates a listing" do
      Listing.create("name")
      listings = Listing.all
      names = listings.map(&:name)
      expect(names).to include ("name")
    end
  end

  describe ".name" do
    it "shows the name of a listing" do
      listing = Listing.create("name")
      expect(listing.name).to eq ("name")
    end
  end

end
