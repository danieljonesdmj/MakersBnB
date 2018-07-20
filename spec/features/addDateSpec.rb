feature 'Add a Date' do
  scenario 'User adds available date to his existing listing' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    click_button('My Listings')
    fill_in('name', :with => 'House in The Wirral')
    fill_in('description', :with => 'Woolie-backs only')
    fill_in('price', :with => '999')
    fill_in('date', :with => '123')
    click_button('Add Listing')
    expect(page).to have_content 'Date: 123'
  end
end
