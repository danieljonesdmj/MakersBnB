require 'request'

describe Request do
  describe '.create' do
    it 'should create a request with a listing_id and requester_id' do
      request = Request.create('listing_id', 'requester_id')
      expect(request.user_id).to eq('requester_id')
    end
  end

  xdescribe '.approve' do
    it '' do

    end
  end
end
