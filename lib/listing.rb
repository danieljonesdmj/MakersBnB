require_relative 'request'
require_relative 'listings_dates'

class Listing

  attr_reader :id, :name, :description, :price, :owner_id

  def initialize(id, name, owner_id, description, price)
    @id = id
    @name = name
    @owner_id = owner_id
    @description = description
    @price = price
  end

  def self.create(name, owner_id, description, price)
    Listing.switch_database
#     result = @connection.exec("INSERT INTO listings (name, owner_id) VALUES('#{name}', '#{owner_id}') RETURNING id, name, owner_id")

#     listing = Listing.new(result.first['id'], result.first['name'], result.first['owner_id'])

#     # create request object

#     Request.create(listing.id, owner_id)
#     listing
    result = @connection.exec("INSERT INTO listings (name, owner_id, description, price) VALUES('#{name}', '#{owner_id}', '#{description}', '#{price}') RETURNING id, name, owner_id, description, price")
    listing = Listing.new(result.first['id'], result.first['name'], result.first['owner_id'], result.first['description'], result.first['price'])
    Request.create(listing.id, owner_id)
    listing
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

  def self.retrieve_other(owner_id)
    # retrieves all listings except those the owner is hosting
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings WHERE owner_id!='#{owner_id}'")
    result.map { |listing| Listing.new(listing['id'], listing['name'], listing['owner_id'], result.first['description'], result.first['price'])}
  end

  def self.retrieve_listing(listing_id)
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings WHERE id='#{listing_id}'")
    Listing.new(result.first['id'], result.first['name'], result.first['owner_id'], result.first['description'], result.first['price'])
  end

  def self.available_dates(listing)
    ListingsDates.return_dates(listing)
  end
  # private
  #
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
