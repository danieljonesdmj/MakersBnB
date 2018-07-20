class ListingsDates

  attr_reader :id, :date_id, :listing_id

  def initialize(id, listing_id, tag_id)
    @id = id
    @listing_id = listing_id
    @tag_id = tag_id
  end

  def self.create(date_id, listing_id)
    ListingsDates.switch_database
    result = @connection.exec("INSERT INTO listings_dates (date_id, listing_id) VALUES('#{date_id}','#{listing_id}') RETURNING id, date_id, listing_id")
    ListingsDates.new(result.first['id'],result.first['date_id'],result.first['listing_id'])
  end

  def self.all
    ListingsDates.switch_database
    result = connection.exec("SELECT * FROM listings_dates")
    result.map { |listing_date| ListingsDates.new(listing_date['id'],listing_date['date_id'],listing_date['listing_id']) }
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
