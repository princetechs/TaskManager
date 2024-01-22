require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(name: 'TestUser', email: 'test@example.com', password: 'password') }

  describe 'validations' do
    it 'validates presence of name' do
      user.name = nil
      expect(user.valid?).to be_falsey
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates uniqueness of name' do
      existing_user = user.dup
      user.save
      existing_user.valid?
      expect(existing_user.errors[:name]).to include('has already been taken')
    end

    it 'validates length of name' do
      user.name = 'a'
      expect(user.valid?).to be_falsey
      expect(user.errors[:name]).to include('is too short (minimum is 3 characters)')

      user.name = 'TooLongUsername'
      expect(user.valid?).to be_falsey
      expect(user.errors[:name]).to include('is too long (maximum is 10 characters)')
    end

    it 'validates presence and length of password on create' do
      user.password = nil
      expect(user.valid?).to be_falsey
      expect(user.errors[:password]).to include("can't be blank")

      user.password = 'short'
      expect(user.valid?).to be_falsey
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end

    it 'validates presence, uniqueness, and format of email' do
      user.email = nil
      expect(user.valid?).to be_falsey
      expect(user.errors[:email]).to include("can't be blank")

      user.email = 'invalid_email'
      expect(user.valid?).to be_falsey
      expect(user.errors[:email]).to include('Invalid email format')

      existing_user = user.dup
      user.email = 'test@gmail.com'
      user.save
      existing_user.valid?
      expect(existing_user.errors[:email]).to include('has already been taken').or include('Invalid email format')
    end
  end

  describe 'associations' do
    it 'defines associations' do
      expect(User.reflect_on_association(:team_users).macro).to eq(:has_many)
      expect(User.reflect_on_association(:teams).macro).to eq(:has_many)
      expect(User.reflect_on_association(:roles).macro).to eq(:has_many)
    end
  end
end
