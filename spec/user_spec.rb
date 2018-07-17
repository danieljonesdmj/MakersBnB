require 'user'

describe User do
  describe 'user.add' do
    it 'creates a new user' do
      users = User.add('username', 'password')
      expect(User.all).to include(users)
    end
  end
  describe 'user.authenticate' do
    it 'authenticates a user' do
      users = User.add('John', 'JPassword')
      expect(User.authenticate('John', 'JPassword')).to eq(users)
    end
  end
end
