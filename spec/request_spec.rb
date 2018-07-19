require 'request'

describe Request do

  describe '.create' do
    it 'should create a request with a listing_id and requester_id' do
      user = User.add('username', 'password')
      listing = Listing.create('Holiday_Home', user.id)
      expect(Request.available).to include (listing)
    end
  end

  describe '.approve' do
    it 'should mark a request as approved' do
      user = User.add('username', 'password')
      listing = Listing.create('Holiday_Home', user.id)
      request = Request.create(listing.id)
      approval = Request.approve(request.id)
      expect(approval.is_approved).to be true
    end
  end

  # describe '.retrieve_available' do
  #   it 'retrieves all unrequested  '
  # end

end
