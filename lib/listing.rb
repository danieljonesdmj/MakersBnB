class Listing

  attr_reader :id, :name, :description, :price

  def initialize(id, name, owner_id, description, price)
    @id = id
    @name = name
    @owner_id = owner_id
    @description = description
    @price = price
  end

  def self.create(name, owner_id, description, price)
    Listing.switch_database
    result = @connection.exec("INSERT INTO listings (name, owner_id, description, price) VALUES('#{name}', '#{owner_id}', '#{description}', '#{price}') RETURNING id, name, owner_id, description, price")
    Listing.new(result.first['id'], result.first['name'], result.first['owner_id'], result.first['description'], result.first['price'])
  end

  def self.all
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings")
    result.map { |listing| Listing.new(listing['id'], listing['name'], listing['owner_id'], result.first['description'], result.first['price']) }
  end

  def self.user_listings(owner_id)
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings WHERE owner_id='#{owner_id}'")
    result.map { |listing| Listing.new(listing['id'], listing['name'], listing['owner_id'], result.first['description'], result.first['price']) }
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
