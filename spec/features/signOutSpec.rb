
feature 'Sign Out' do
  scenario 'User signs out' do
  visit('/')
  fill_in('username', :with => 'Daniel')
  fill_in('password', :with => 'pa$$word1')
  click_button('Submit')
  click_button('Sign Out')
  expect(page).to have_content 'To get set up and staying in the home of your dreams, please sign in below.'
end
end
