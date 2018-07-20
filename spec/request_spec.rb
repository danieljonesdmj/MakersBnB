require 'request'

describe Request do

  describe '.create' do  
    it 'should create a request with a listing_id and requester_id' do
      listing = Listing.create('Holiday_Home', user.id, 'description', 100)
      request = Request.create(listing.id, user.id)
      expect(request.user_id).to eq(user.id)
    end
  end
  
  describe '.available' do
    it 'should create a request automatically when created' do
      user = User.add('username', 'password')
      listing = Listing.create('Holiday_Home', user.id, 'description', 100)
      expect(Request.available).to include (listing)
    end
  end

  describe '.approve' do
    it 'should mark a request as approved' do
      user = User.add('username', 'password')
      listing = Listing.create('Holiday_Home', user.id, 'description', 100)
      request = Request.create(listing.id, user.id)
      approval = Request.approve(request.id)
      expect(approval.id).to eq request.id
    end
  end

  describe '.my_requests' do
    it 'should return a request made on the users space' do
      user = User.add('username', 'password')
      user2 = User.add('user2', 'password')
      listing = Listing.create('Holiday_Home', user.id)
      request = Request.make_request(listing.id, user2.id)
      my_requests = Request.my_requests(user.id)
      expect(my_requests.first.id).to eq request.id
    end
  end

  describe '.return_request' do
    it 'returns a specific listing' do
      user = User.add('username', 'password')
      listing = Listing.create('Holiday_Home', user.id)
      request = Request.return_request(listing.id)
      expect(request.listing_id).to eq listing.id
    end
  end

  describe '.reject' do
    it 'rejects a request' do
      user = User.add('username', 'password')
      listing = Listing.create('Holiday_Home', user.id)
      request = Request.return_request(listing.id)
      rejection = Request.reject(request.id)
      expect(rejection.id).to eq request.id
    end
  end

  # describe '.retrieve_available' do
  #   it 'retrieves all unrequested  '
  # end

end
