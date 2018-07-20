require "listings_dates"

describe ListingsDates do

  describe '.add_date' do
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

  describe '.add_listing' do
    it 'adds a listing to a date' do
      date = Date.create('2018-01-01')
      user = User.add('John', 'JPassword')
      listing = Listing.create("name", user.id, "description", 100)
      ListingsDates.add_listing(listing.id, date.id)
      expect(ListingsDates.return_listings(date)).to eq [listing]
    end
  end

  describe '#return_listings(date)' do
    it 'returns all the listings of a specific date' do
      date = Date.create('2018-01-01')
      user = User.add('John', 'JPassword')
      listing1 = Listing.create("name", user.id, "description", 100)
      listing2 = Listing.create("name", user.id, "description", 100)
      ListingsDates.add_listing(listing1.id, date.id)
      ListingsDates.add_listing(listing2.id, date.id)
      expect(ListingsDates.return_listings(date)).to eq [listing1, listing2]

    end
  end
end
