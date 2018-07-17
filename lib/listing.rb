class Listing

  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.create(name)
    Listing.switch_database
    result = @connection.exec("INSERT INTO listings (name) VALUES('#{name}') RETURNING id, name")
    Listing.new(result.first['id'], result.first['name'])
  end

  def self.all
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings")
    result.map { |listing| Listing.new(listing['id'], listing['name']) }
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
