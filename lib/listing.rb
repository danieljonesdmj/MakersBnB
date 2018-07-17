class Listing

  def self.create(name)
    Listing.switch_database
    @connection.exec("INSERT INTO listings (name) VALUES('#{name}')")
  end

  def self.all
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings")
    result.map { |listing| listing['name'] }
  end

  private

  def self.switch_database
    if ENV['RACK_ENV'] == 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end
end
