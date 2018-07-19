require 'sinatra/base'
require './lib/user'
require './lib/listing'

class MakersBNB < Sinatra::Base
  set :method_override, true
  enable :sessions

  get '/' do
    # Sign-in page
    erb :sign_in_page
  end

  get '/all_listings' do
    # Assign user to User object
    @user = User.retrieve(session[:id]) # Method not written yet
    # Assign listings to array of listings objects
    @listings = Listing.all
    # :listings view should pull User and Listings info and show on page
    erb :listings
  end

  get '/my_listings' do
    @user = User.retrieve(session[:id])
    @user_listings = Listing.user_listings(session[:id])
    erb :my_listings
  end

  post '/new_session' do
    # Authenticate User...
    user = User.authenticate(params[:username], params[:password])

    if user
      # If authentication successful, assign sesssion 'id' to this user's id.
      session[:id] = user.id
      redirect '/all_listings'
    else
      # Otherwise, return to sign in page.
      redirect '/'
    end

  end

  post '/add_listing' do
    listing = Listing.create(params[:name], session[:id])
    redirect ('/all_listings')
  end

  run! if app_file == $0

end
