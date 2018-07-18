require "listing"
require "user"

describe Listing do

  describe ".create" do
    it "creates a listing" do
      owner = User.new('Bill', 'password')
      listing = Listing.create("name", owner.id)
      listings = Listing.all
      names = listings.map(&:name)
      expect(names).to eq (listing)
    end
  end

  describe ".name" do
    it "shows the name of a listing" do
      listing = Listing.create("name")
      expect(listing.name).to eq ("name")
    end
  end

end
