require 'pg'

class User
  attr_reader :username, :password, :id

  def initialize(id, username, password)
    @id = id
    @username = username
    @password = password
  end

  def self.all
    User.switch_database
    result = @connection.exec("SELECT * FROM users")
    result.map do |user|
      User.new(user['id'], user['username'], user['password'])
    end
  end

  def self.add(username, password)
    User.switch_database
    result = @connection.exec("INSERT INTO users (username, password) VALUES ('#{username}', '#{password}') RETURNING id, username, password;")
    User.new(result.first['id'], result.first['username'], result.first['password'])
  end

  def ==(username)
    @username == username.username
  end

  def self.switch_database
    if ENV['RACK_ENV'] == 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end
end
