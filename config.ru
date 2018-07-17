require 'rake'

require_relative './app'

Rake.application.load_rakefile

# creates the databases each time the app is launched
Rake::Task['setup_databases'].execute

# resets the dev database tables when the app is launched and provides some useful dummy data
Rake::Task['reset_dev_tables'].execute

run MakersBNB
