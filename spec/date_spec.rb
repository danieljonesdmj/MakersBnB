require 'date'

describe Date do
  describe '.create' do
    it 'should return id' do
      dates = Date.create('2018-06-01')
      expect(dates.dates).to eq('2018-06-01')
    end
  end

  describe '.date_id' do
    it 'should return the id of a date in database' do
      dates = Date.create('2018-06-01')
      expect(Date.dates(dates.id)).to eq dates.dates
    end
  end

  describe '#dates(date_id)' do
    it 'returns the id of a date' do
      dates = Date.create('2018-06-01')
      expect(Date.dates(dates.id)).to eq('2018-06-01')
    end
  end
end
