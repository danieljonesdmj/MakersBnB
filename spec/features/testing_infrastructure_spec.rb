
feature 'Homepage' do
  scenario 'Test infrastructure works' do
    visit ('/')
    expect(page).to have_content 'Welcome to MakersBnB'
  end
end

feature 'Sign Up' do
  scenario 'User makes new account' do
    visit('/')
    fill_in('new_username', :with => 'Cristiano')
    fill_in('new_password', :with => 'Juve')
    click_button('Create Account')
    expect(page).to have_content 'Welcome, Cristiano'
  end
end

feature 'Sign In' do
  scenario 'User signs in' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    expect(page).to have_content 'Welcome, Daniel'
  end

  scenario 'User sees all listings' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    expect(page).to have_content 'Penthouse flat in New York'
  end

  scenario 'User sees their listings' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('My Listings')
    expect(page).not_to have_content 'Chateau on French Alps'
  end

  scenario 'User sees their listings then returns to All Listings' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('My Listings')
    click_button('All Listings')
    expect(page).to have_content 'Chateau on French Alps'
  end

  scenario 'User adds a new listing' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('My Listings')
    fill_in('name', :with => 'House in The Wirrell')
    click_button('Add Listing')
    expect(page).to have_content 'House in The Wirrell'
  end
end
