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
    it 'returns nil if an incorrect password is submitted' do
      User.add('John', 'JPassword')
      expect(User.authenticate('John', 'wrong')).to be_nil
    end
  end

  describe 'user.find' do
    it 'retrieves a specific user instance' do
      test_user = User.add('NewUser', 'NewPassword')
      expect(User.retrieve(test_user.id)).to eq test_user
    end
  end
end
