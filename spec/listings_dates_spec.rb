require "listings_dates"

describe ListingsDates do

  describe '.create' do
    it 'adds a date to a listing' do
      date = Date.create('2018-01-01')
      user = User.add('John', 'JPassword')
      listing = Listing.create("name", user.id, "description", 100)
      ListingsDates.add_date(date.id, listing.id)
      expect(ListingsDates.return_dates(listing)).to eq [date]
    end
  end

  describe '#return_dates(listing)' do
    it 'returns all the dates of a specific listing' do
      date1 = Date.create('2018-01-01')
      date2 = Date.create('2018-01-02')
      user = User.add('John', 'JPassword')
      listing = Listing.create("name", user.id, "description", 100)
      ListingsDates.add_date(date1.id, listing.id)
      ListingsDates.add_date(date2.id, listing.id)
      expect(ListingsDates.return_dates(listing)).to eq [date1, date2]

    end
  end


end
