require 'sinatra/base'
require './lib/user'
require './lib/listing'
require './lib/request'

class MakersBNB < Sinatra::Base
  set :method_override, true
  enable :sessions

  get '/' do
    # Sign-in page
    erb :sign_in_page
  end

  get '/:id/all_listings' do
    # Assign user to User object
    @user = User.retrieve(session[:id]) # Method not written yet
    # Assign listings to array of available listings...
    # @listings = Listing.retrieve_other(session[:id])
    p requests = Request.available
    @listings = requests.map { |request| Listing.retrieve_listing(request.listing_id) }
    # :listings view should pull User and Listings info and show on page
    erb :listings
  end

  get '/:id/my_listings' do
    @user = User.retrieve(session[:id])
    @user_listings = Listing.user_listings(session[:id])
    erb :my_listings
  end

  get '/:id/confirm_request' do
    @user = User.retrieve(session[:id])
    erb :confirm_request
  end

  post '/new_session' do
    # Authenticate User...
    user = User.authenticate(params[:username], params[:password])

    if user
      # If authentication successful, assign sesssion 'id' to this user's id.
      session[:id] = user.id
      redirect "/#{user.id}/all_listings"
    else
      # Otherwise, return to sign in page.
      redirect '/'
    end

  end

  patch '/:id/request' do
    params[:listing_id]
    user = User.retrieve(session[:id])
    listing = Listing.retrieve_listing(params[:listing_id])
    p request = Request.make_request(params[:listing_id], user.id)
    # p Request.make_request(listing.id, user.id)
    redirect "/'#{listing.id}'/confirm_request"
  end

  post '/add_listing' do
    listing = Listing.create(params[:name], session[:id])
    redirect ("/#{session[:id]}/my_listings")
  end

  post '/new_user' do
    user = User.add(params[:new_username], params[:new_password])
    session[:id] = user.id
    redirect "/#{user.id}/my_listings"
  end

  run! if app_file == $0

end
