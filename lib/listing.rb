class Listing

  attr_reader :id, :name

  def initialize(id, name, owner_id)
    @id = id
    @name = name
    @owner_id = owner_id
  end

  def self.create(name, owner_id)
    Listing.switch_database
    result = @connection.exec("INSERT INTO listings (name, owner_id) VALUES('#{name}', '#{owner_id}') RETURNING id, name, owner_id")
    Listing.new(result.first['id'], result.first['name'], result.first['owner_id'])
  end

  def self.all
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings")
    result.map { |listing| Listing.new(listing['id'], listing['name'], listing['owner_id']) }
  end

  private

  def ==(other)
    @id == other.id
  end

  def self.switch_database
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end
end
