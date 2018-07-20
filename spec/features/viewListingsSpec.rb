feature 'View All Listings' do
  scenario 'User sees all listings' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    expect(page).to have_content 'Chateau on French Alps'
  end

  scenario 'User sees all available listings except theirs' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('My Listings')
    fill_in('name', :with => 'House in The Wirral')
    fill_in('description', :with => 'Woolie-backs only')
    fill_in('price', :with => '999')
    click_button('Add Listing')
    click_button('All Listings')
    expect(page).to have_content 'House in The Wirral (your space)'
  end

  scenario 'User sees their listings' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('My Listings')
    expect(page).to have_no_content 'Chateau on French Alps'
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
    fill_in('name', :with => 'House in The Wirral')
    fill_in('description', :with => 'Woolie-backs only')
    fill_in('price', :with => '999')
    click_button('Add Listing')
    expect(page).to have_content 'House in The Wirral'
  end
end
