require 'request'

describe Request do
  describe '.create' do
    it 'should create a request with a listing_id and requester_id' do
      user = User.add('username', 'password')
      listing = Listing.create('Holiday_Home', user.id)
      request = Request.create(listing.id, user.id)
      expect(request.user_id).to eq(user.id)
    end
  end

  xdescribe '.approve' do
    it '' do

    end
  end
end
