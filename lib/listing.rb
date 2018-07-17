class Listing

  def self.create(name)
    User.switch_database
    @connection.exec("INSERT INTO listings (name) VALUES('#{name}')")
  end

  def self.all
    User.switch_database
    result = @connection.exec("SELECT * FROM listings")
    result.map { |listing| listing['name'] }
  end


  def self.switch_database
    if ENV['RACK_ENV'] == 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end
end
