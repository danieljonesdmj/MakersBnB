require "listing"
require "user"
require "request"

describe Listing do

  describe ".create" do
    it "creates a listing" do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id, "description", 100)
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
      listing = Listing.create("name", owner.id, "description", 100)
      expect(listing.name).to eq "name"
    end
  end

  describe ".user_listings" do
    it "can return all listings for a specific user id " do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id, "description", 100)
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
    
  describe ".description" do
    it "shows the description of a listing" do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id, "description", 100)
      expect(listing.description).to eq "description"
    end
  end

  describe ".price" do
    it "shows the description of a listing" do
      owner = User.add('Bill', 'password')
      listing = Listing.create("name", owner.id, "description", 100)
      expect(listing.price).to eq '100'
    end

  end

end
