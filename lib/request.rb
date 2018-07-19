class Request

  attr_reader :id, :listing_id, :requester_id, :host_id, :is_approved

  def initialize(id, listing_id, requester_id, host_id, is_requested, is_approved)
    @id = id
    @listing_id = listing_id
    @requester_id = requester_id
    @host_id = host_id
    @is_approved = is_approved
    @is_requested = is_requested
  end

  def self.create(listing_id, host_id)
    Request.switch_database
    result = @connection.exec("INSERT INTO requests (listing_id, host_id, is_requested, is_approved) VALUES ('#{listing_id}', '#{host_id}', FALSE, FALSE) RETURNING id, listing_id, requester_id, is_requested, is_approved;")
    Request.new(result.first['id'],result.first['listing_id'], result.first['requester_id'], result.first['host_id'], result.first['is_requested'], result.first['is_approved'])
  end

  def self.make_request(listing_id, requester_id)
    Request.switch_database
    result = @connection.exec("UPDATE requests SET requester_id='#{requester_id}', is_requested = TRUE WHERE listing_id='#{listing_id}' RETURNING id, listing_id, requester_id, host_id, is_requested, is_approved;")
    Request.new(result.first['id'],result.first['listing_id'], result.first['requester_id'], result.first['host_id'], result.first['is_requested'], result.first['is_approved'])
  end

  def self.approve(request_id)
    Request.switch_database
    result = @connection.exec("UPDATE requests SET is_approved = TRUE WHERE id = #{request_id} RETURNING id, listing_id, requester_id, host_id, is_requested, is_approved;")
    Request.new(result.first['id'],result.first['listing_id'], result.first['requester_id'], result.first['host_id'], result.first['is_requested'], result.first['is_approved'])
  end

  def self.reject(request_id)
    Request.switch_database
    result = @connection.exec("UPDATE requests SET is_approved = FALSE, is_requested = FALSE WHERE id = #{request_id} RETURNING id, listing_id, requester_id, host_id, is_requested, is_approved;")
    Request.new(result.first['id'],result.first['listing_id'], result.first['requester_id'], result.first['host_id'], result.first['is_requested'], result.first['is_approved'])
  end

  def self.available
    # returns all available listings
    Request.switch_database
    result = @connection.exec("SELECT * FROM requests WHERE is_requested=FALSE")
    result.map {|request| Request.new(request['id'], request['listing_id'], request['requester_id'], request['host_id'], request['is_requested'], request['is_approved'])}
  end

  def self.my_requests(user_id)
    Request.switch_database
    result = @connection.exec("SELECT * FROM requests WHERE host_id='#{user_id}'")
    result.map {|request| Request.new(request['id'], request['listing_id'], request['requester_id'], request['host_id'], request['is_requested'], request['is_approved'])}
  end

  def self.return_request(listing_id)
    Request.switch_database
    result = @connection.exec("SELECT * FROM requests WHERE listing_id='#{listing_id}'")
    Request.new(result.first['id'],result.first['listing_id'], result.first['requester_id'], result.first['host_id'], result.first['is_requested'], result.first['is_approved'])
  end

  private

  def ==(other)
    @listing_id == other.id
  end

  def self.switch_database
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end
end
