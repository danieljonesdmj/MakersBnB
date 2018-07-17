require 'pg'
require './lib/user'
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
    connection.exec("CREATE TABLE listings (id SERIAL PRIMARY KEY, name VARCHAR(60));")
  end
end

task :reset_test_tables do
  # resets the test database tables before each test is run
  p 'Resetting database...'
  connection = PG.connect(dbname: 'makers_bnb_test')
  # clear the users and peeps tables:
  connection.exec("TRUNCATE users, listings;")
  # add some test data, for example:
  User.add('Daniel', 'pa$$word1')
  User.add('Layth', 'pa$$w0rd2')
  User.add('Eli', 'pa$$w0rd3')
  User.add('Ben', 'pa$$w0rd4')
end

task :reset_dev_tables do
  # resets the dev database tables when the app is launched and provides some useful dummy data
  p "Resetting development database tables...type 'y' to confirm that you want to reset your data!"
  confirm = STDIN.gets.chomp
  return unless confirm == 'y'
  connection = PG.connect(dbname: 'makers_bnb')
  connection.exec("TRUNCATE users, listings;")
  # add some test data, for example:
  User.add('Daniel', 'pa$$word1')
  User.add('Layth', 'pa$$w0rd2')
  User.add('Eli', 'pa$$w0rd3')
  User.add('Ben', 'pa$$w0rd4')
  # User.create('test', 'test', 'test', 'test')
  # Peep.create(han.id, 'Laugh it up fuzzball.')
  # Peep.create(luke.id, 'Im Luke Skywalker. Im here to rescue you!')
  # Peep.create(leia.id, 'Help me Obiwan Kenobi. Youre my only hope.')
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
