require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  context 'when all parameters are valid' do
    before :each do
      # Use 'create' to persist the user in the database, and
      # make sure it's an instance variable.
      @u = FactoryBot.create :user
    end
    
    it 'validates successfully' do
      expect(@u).to be_valid
    end

    it 'saves to the database' do
      expect(User.where(email: @u.email)).to exist
    end
  end

  context 'when name parameter is missing' do
    it 'is invalid' do
      u = FactoryBot.build(:user, name: '')
      u.valid?
      expect(u.errors[:name]).to include("can't be blank")
    end
  end

  context 'when name parameter is too short' do
    it 'is invalid' do
      u = FactoryBot.build(:user, name: 'x')
      u.valid?
      expect(u.errors[:name]).to include('is too short (minimum is 2 characters)')
    end
  end

  context 'when email parameter is missing' do
    it 'is invalid' do
      u = FactoryBot.build(:user, email: nil)
      u.valid?
      expect(u.errors[:email]).to include("can't be blank")
    end
  end

  context 'when email parameter is already taken' do
    before :each do
      FactoryBot.create(:user, email: 'tester@test.com')
      @u = FactoryBot.build(:user, email: 'tester@test.com')
    end

    it 'is invalid' do
      @u.valid?
      expect(@u.errors[:email]).to include('has already been taken')
    end

    it 'does not save to the database' do
      expect(User.where(email: 'tester@test.com').length).to eq(1)
    end
  end

  context 'when email parameter is in the wrong format' do
    it 'is invalid' do
      u = FactoryBot.build(:user, email: 'tester.com')
      u.valid?
      expect(u.errors[:email]).to include('is invalid')
    end
  end

  context 'when password parameter is missing' do
    it 'is invalid' do
      u = FactoryBot.build(:user, password: nil)
      u.valid?
      expect(u.errors[:password]).to include("can't be blank")
    end
  end

  context 'when parameter parameter is too short' do
    it 'is invalid' do
      u = FactoryBot.build(:user, password: 'wut')
      u.valid?
      expect(u.errors[:password]).to include('is too short (minimum is 8 characters)')
    end
  end

  context 'when password confirmation parameter is missing' do
    it 'is invalid' do
      u = FactoryBot.build(:user, password_confirmation: nil)
      u.valid?
      expect(u.errors[:password_confirmation]).to include("can't be blank")
    end
  end

  context 'when password confirmation does not match password' do
    it 'is invalid' do
      u = FactoryBot.build(:user, password_confirmation: 'whenever')
      u.valid?
      expect(u.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  it 'cleans up the email address before creation' do
    user = FactoryBot.create(:user, email: 'jonaThAn@coDe and card boa rd.com')
    expect(user.email).to eq('jonathan@codeandcardboard.com')
  end
end
