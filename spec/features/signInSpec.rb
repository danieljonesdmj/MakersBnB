feature 'Sign In' do
  scenario 'User signs in' do
    visit('/')
    fill_in('username', :with => 'Daniel')
    fill_in('password', :with => 'pa$$word1')
    click_button('Submit')
    expect(page).to have_content 'Welcome, Daniel'
  end
end
