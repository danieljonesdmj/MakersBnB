feature 'View All Listings'
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
