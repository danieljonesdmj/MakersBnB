class Request

  attr_reader :user_id

  def initialize(listing_id, user_id, is_approved)
    @listing_id = listing_id
    @user_id = user_id
    @is_approved = is_approved
  end

  def self.create(listing_id, requester_id)
    Request.switch_database
    result = @connection.exec("INSERT INTO requests (listing_id, requester_id, is_approved) VALUES ('#{listing_id}', '#{requester_id}', FALSE) RETURNING listing_id, requester_id, is_approved;")
    Request.new(result.first['listing_id'], result.first['requester_id'], result.first['is_approved'])
  end

  def self.approve
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
