require_relative 'date'

class ListingsDates

  attr_reader :id, :date_id, :listing_id

  def initialize(id, listing_id, date_id)
    @id = id
    @listing_id = listing_id
    @date_id = date_id
  end

  def self.add_date(date_id, listing_id)
    ListingsDates.switch_database
    result = @connection.exec("INSERT INTO listings_dates (date_id, listing_id) VALUES('#{date_id}','#{listing_id}') RETURNING id, date_id, listing_id")
    result.map { |date| ListingsDates.new(date['id'], date['listing_id'], date['date_id']) }
  end

  def self.return_dates(listing)
    ListingsDates.switch_database
    result = @connection.exec("SELECT * FROM listings_dates WHERE listing_id='#{listing.id}'")

    listings_dates = result.map { |date| ListingsDates.new(date['id'], date['listing_id'], date['date_id'])}

    listings_dates.map do |junction|
      junction.date_id
      date = @connection.exec("SELECT * FROM dates WHERE id='#{junction.date_id}';")
      Dates.new(date.first['id'], date.first['dates'])
        end
  end

  def self.add_listing(listing_id, date_id)
    ListingsDates.switch_database
    result = @connection.exec("INSERT INTO listings_dates (date_id, listing_id) VALUES('#{date_id}','#{listing_id}') RETURNING id, date_id, listing_id")
    result.map { |date| ListingsDates.new(date['id'], date['listing_id'], date['date_id']) }
  end

  def self.return_listings(date)
    ListingsDates.switch_database
    # return all dates from listing junction
    result = @connection.exec("SELECT * FROM listings_dates WHERE date_id='#{date.id}'")

    listings_dates = result.map { |date| ListingsDates.new(date['id'], date['listing_id'], date['date_id'])}

    # wrap each date up as a date object

    listings_dates.map do |junction|
      listing = @connection.exec("SELECT * FROM listings WHERE id='#{junction.listing_id}';")
      Listing.new(listing.first['id'], listing.first['name'], listing.first['owner_id'], listing.first['description'], listing.first['price'])
        end
  end

  def ==(other)
    @id == other.id
  end

  private

  def self.switch_database
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end


end
