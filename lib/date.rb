class Date
  attr_reader :id, :dates

  def initialize(id, dates)
    @id = id
    @dates = dates
  end

  def self.create(dates)
    Date.switch_database
    result = @connection.exec("INSERT INTO dates (dates) VALUES ('#{dates}') RETURNING id, dates;")
    Date.new(result.first['id'], result.first['dates'])
  end

  def self.date_id(dates)
    Date.switch_database
    result = @connection.exec("SELECT * FROM dates WHERE dates='#{dates}';")
    result.first['id']
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
