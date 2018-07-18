require "listing"
require "user"

describe Listing do

  describe ".create" do
    it "creates a listing" do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id)
      listings = Listing.all
      # names = listings.map(&:name)
      expect(listings).to include (listing)
    end
  end

  describe ".name" do
    it "shows the name of a listing" do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id)
      listings = Listing.all
      expect(listings).to include (listing)
    end
  end

end
