require 'sinatra/base'
require './lib/user'
require './lib/listing'

class MakersBNB < Sinatra::Base

  get '/' do
    'Hello world!'
  end

  run! if app_file == $0

end
