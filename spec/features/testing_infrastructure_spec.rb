feature 'Homepage' do
  scenario 'Test infrastructure works' do
    visit ('/')
    expect(page).to have_content 'Welcome to MakersBnB'
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
    expect(page).to_not have_content 'Chateau on French Alps'
  end

end
