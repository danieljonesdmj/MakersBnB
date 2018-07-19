feature 'Sign Up' do
  scenario 'User makes new account' do
    visit('/')
    fill_in('new_username', :with => 'Cristiano')
    fill_in('new_password', :with => 'Juve')
    click_button('Create Account')
    expect(page).to have_content 'Welcome, Cristiano'
  end
end
