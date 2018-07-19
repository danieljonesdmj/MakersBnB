feature 'Approve Request' do
  scenario 'User approves a request' do
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
    expect(page).to have_button('Approve')
  end
end
