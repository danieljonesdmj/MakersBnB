require 'sinatra/base'
require './lib/user'
require './lib/listing'

class MakersBNB < Sinatra::Base
  set :method_override, true
  enable :sessions

  get '/' do
    # Sign-in page
    erb :index
  end

  get '/:id/listings' do
    erb :listings
  end

  post '/:id/session' do
    # Authenticate User, redirect to listings...
    user = User.authenticate(params[:username, params[:password]])

    if user
      # If authentication successful, assign sesssion 'id' to this user's id.
      session[:id] = user.id
      redirect '/:id/listings'
    else
      # Otherwise, return to sign in page
      redirect '/'

    redirect '/:id/listings'
  end

  run! if app_file == $0

end
