feature 'Test' do
  scenario 'Test infrastructure works' do
    visit ('/')
    expect(page).to have_content 'Hello world'
  end
end
