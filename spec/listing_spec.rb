require "listing"
require "user"
require "request"

describe Listing do

  describe ".create" do
    it "creates a listing" do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id)
      listings = Listing.all
      # names = listings.map(&:name)
      expect(listings).to include (listing)
    end

    # it 'creates a request object each time' do
    #   owner = User.add('Bill', 'password')
    #   listing = Listing.create("name", owner.id)
    #   expect(Request.available).to include listing
    # end
  end

  describe ".name" do
    it "shows the name of a listing" do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id)
      listings = Listing.all
      expect(listings).to include (listing)
    end
  end

  describe ".user_listings" do
    it "can return all listings for a specific user id " do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id)
      expect(Listing.user_listings(owner.id)).to include listing
    end
  end

  describe '.retrieve_listing' do
    it 'returns and wraps a specific listing by id' do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id)
      retrieved_listing = Listing.retrieve_listing(listing.id)
      expect(retrieved_listing.id).to eq listing.id
  end
  end

end
