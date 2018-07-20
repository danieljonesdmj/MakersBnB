require_relative 'date'

class ListingsDates

  attr_reader :id, :date_id, :listing_id

  def initialize(id, listing_id, date_id)
    @id = id
    @listing_id = listing_id
    @date_id = date_id
  end

  def self.add_date(dat_id, list_id)
    ListingsDates.switch_database
    result = @connection.exec("INSERT INTO listings_dates (date_id, listing_id) VALUES('#{dat_id}','#{list_id}') RETURNING id, date_id, listing_id")
    (result.map { |date| ListingsDates.new(date['id'], date['listing_id'], date['date_id']) })
    # ListingsDates.new(result.first['id'],result.first['date_id'],result.first['listing_id'])
  end

  def self.return_dates(listing)
    ListingsDates.switch_database
    # return all dates from listing junction
    result = @connection.exec("SELECT * FROM listings_dates WHERE listing_id='#{listing.id}'")

    listings_dates = result.map { |date| ListingsDates.new(date['id'], date['listing_id'], date['date_id'])}

    # wrap each date up as a date object

    listings_dates.map do |junction|
      junction.date_id
      date = @connection.exec("SELECT * FROM dates WHERE id='#{junction.date_id}';")
      Date.new(date.first['id'], date.first['dates'])
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
