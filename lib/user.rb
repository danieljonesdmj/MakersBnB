require 'pg'
require 'bcrypt'

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
    encrypted_password = BCrypt::Password.create(password)
    result = @connection.exec("INSERT INTO users (username, password) VALUES ('#{username}', '#{encrypted_password}') RETURNING id, username, password;")
    User.new(result.first['id'], result.first['username'], result.first['password'])
  end

  def self.authenticate(username, password)
    User.switch_database
    result = @connection.exec("SELECT * FROM users WHERE username = '#{username}'")
    return unless result.any?
    return unless BCrypt::Password.new(result.first['password']) == password
    User.new(result.first['id'], result.first['username'], result.first['password'])
  end

  def ==(username)
    @username == username.username
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
