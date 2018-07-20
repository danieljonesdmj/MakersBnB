feature 'Request' do
  scenario 'User requests a listing' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('Request', :match => :first)
    expect(page).to have_content 'Request Confirmed!'
  end

  scenario 'Requested listing is no longer shown on All Listings' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('Request', :match => :first)
    click_button('Back to Listings')
    expect(page).to have_no_content 'Secluded wood cabin in Sweden with Sauna'
  end
end
