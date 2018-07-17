require 'user'

describe User do
  describe 'user.add' do
    it 'creates a new user' do
    users = User.add('username', 'password')
    expect(User.all).to include(users)
    end
  end
end
