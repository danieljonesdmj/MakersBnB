require 'pg'
require './lib/user'
require './lib/listing'
# EF THINK I MAY NEED TO REQUIRE A FILE FROM LIB HERE?

if ENV['RACK_ENV'] != 'production'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new :spec
  task default: [:spec]
end

task :setup_databases do
  # creates the databases each time the app is launched
  p 'Creating databases...'
  ['makers_bnb', 'makers_bnb_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")
    # when we know what database tables we want:
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE users (id SERIAL PRIMARY KEY, username VARCHAR(60), password VARCHAR(60));")
    connection.exec("CREATE TABLE listings (id SERIAL PRIMARY KEY, name VARCHAR(60), owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE, description VARCHAR(200), price INTEGER);")
    connection.exec("CREATE TABLE requests (id SERIAL PRIMARY KEY, listing_id INTEGER REFERENCES listings(id) ON DELETE CASCADE, requester_id INTEGER REFERENCES users(id) ON DELETE CASCADE, host_id INTEGER REFERENCES users(id), is_requested BOOLEAN, is_approved BOOLEAN);")
    connection.exec("CREATE TABLE dates (id SERIAL PRIMARY KEY, dates DATE);")
    connection.exec("CREATE TABLE listings_dates (id SERIAL PRIMARY KEY, date_id INTEGER REFERENCES listings(id) ON DELETE CASCADE, listing_id INTEGER REFERENCES dates(id) ON DELETE CASCADE);")



  end
end

task :reset_test_tables do
  # resets the test database tables before each test is run
  p 'Resetting database...'
  connection = PG.connect(dbname: 'makers_bnb_test')
  # clear the users and peeps tables:
  connection.exec("TRUNCATE users, listings, requests, dates, listings_dates;")
  # add some test data, for example:
  user1 = User.add('Daniel', 'pa$$word1')
  user2 = User.add('Layth', 'pa$$w0rd2')
  user3 = User.add('Eli', 'pa$$w0rd3')
  User.add('Ben', 'pa$$w0rd4')
  Listing.create('Penthouse flat in New York', user1.id, 'Sip a cocktail in front of the Manhattan skyline', 200)
  Listing.create('Secluded wood cabin in Sweden with Sauna', user2.id, 'Switch off, relax and live the hygge dream', 100)
  Listing.create('Chateau on French Alps', user3.id, 'Skiing by day, vintage wines by night', 150)
end

task :reset_dev_tables do
  # resets the dev database tables when the app is launched and provides some useful dummy data
  p "Resetting development database tables...type 'y' to confirm that you want to reset your data!"
  confirm = STDIN.gets.chomp
  return unless confirm == 'y'
  connection = PG.connect(dbname: 'makers_bnb')
  connection.exec("TRUNCATE users, listings, requests, dates, listings_dates;")
  # add some test data, for example:
  user1 = User.add('Daniel', 'pa$$word1')
  user2 = User.add('Layth', 'pa$$w0rd2')
  user3 = User.add('Eli', 'pa$$w0rd3')
  User.add('Ben', 'pa$$w0rd4')
  Listing.create('Penthouse flat in New York', user1.id, 'Sip a cocktail in front of the Manhattan skyline', 200)
  Listing.create('Secluded wood cabin in Sweden with Sauna', user2.id, 'Switch off, relax and live the hygge dream', 100)
  Listing.create('Chateau on French Alps', user3.id, 'Skiing by day, vintage wines by night', 150)
end

task :teardown do
  # deletes all databases
  p "Deleting databases...type 'y' to confirm that you want to destroy the MakersBNB databases. This will remove all data in those databases!"
  confirm = STDIN.gets.chomp
  return unless confirm == 'y'
  ['makers_bnb', 'makers_bnb_test'].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{database};")
  end
end
