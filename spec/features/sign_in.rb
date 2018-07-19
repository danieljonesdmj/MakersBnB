def sign_in
  visit('/')
  fill_in('username', :with => 'Daniel')
  fill_in('password', :with => 'pa$$word1')
  click_button('Submit')
end
