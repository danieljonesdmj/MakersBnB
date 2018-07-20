require "listings_dates"

describe ListingsDates do

  describe '.create' do
    it 'makes a link between a listing id and a date id' do
      date = Date.create('2018-01-01')
      user = User.add('John', 'JPassword')
      listing = Listing.create("name", user.id, "description", 100)
      link = ListingsDates.create(date.id, listing.id)
      expect(ListingsDates.all).to include link
    end
  end

end
