require_relative 'request'

class Listing

  attr_reader :id, :name, :owner_id

  def initialize(id, name, owner_id)
    @id = id
    @name = name
    @owner_id = owner_id
  end

  def self.create(name, owner_id)
    Listing.switch_database
    result = @connection.exec("INSERT INTO listings (name, owner_id) VALUES('#{name}', '#{owner_id}') RETURNING id, name, owner_id")

    listing = Listing.new(result.first['id'], result.first['name'], result.first['owner_id'])

    # create request object

    Request.create(listing.id)
    listing
  end

  def self.all
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings")
    result.map { |listing| Listing.new(listing['id'], listing['name'], listing['owner_id']) }
  end

  def self.user_listings(owner_id)
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings WHERE owner_id='#{owner_id}'")
    result.map { |listing| Listing.new(listing['id'], listing['name'], listing['owner_id']) }
  end

  def self.retrieve_other(owner_id)
    # retrieves all listings except those the owner is hosting
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings WHERE owner_id!='#{owner_id}'")
    result.map { |listing| Listing.new(listing['id'], listing['name'], listing['owner_id'])}
  end

  def self.retrieve_listing(listing_id)
    Listing.switch_database
    result = @connection.exec("SELECT * FROM listings WHERE id='#{listing_id}'")
    Listing.new(result.first['id'], result.first['name'], result.first['owner_id'])
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
