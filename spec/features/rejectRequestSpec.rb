feature 'Reject Request' do
  scenario 'User rejects a request' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('Request', :match => :first)
    click_button('Back to Listings')
    click_button('Sign Out')
    fill_in('username', :with => 'Layth')
    fill_in('password', :with => 'pa$$w0rd2')
    click_button('Submit')
    click_button('My Listings')
    click_button('Reject')
    click_button('Back to My Listings')
    click_button('All Listings')
    expect(page).to have_content 'Secluded wood cabin in Sweden with Sauna'
  end
end
