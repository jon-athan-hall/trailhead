require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:role)).to be_valid
  end

  context 'when all parameters are valid' do
    before :each do
      @r = FactoryBot.create :role
    end

    it 'validates successfully' do
      expect(@r).to be_valid
    end

    it 'saves to the database' do
      expect(Role.where(name: @r.name)).to exist
    end
  end

  context 'when name parameter is missing' do
    it 'is invalid' do
      r = FactoryBot.build(:role, name: nil)
      r.valid?
      expect(r.errors[:name]).to include("can't be blank")
    end
  end

  context 'when name parameter is already taken' do
    before :each do
      FactoryBot.create(:role, name: 'tester')
      @r = FactoryBot.build(:role, name: 'tester')
    end

    it 'is invalid' do
      @r.valid?
      expect(@r.errors[:name]).to include('has already been taken')
    end

    it 'does not save to the database' do
      expect(Role.where(name: 'tester').length).to eq(1)
    end
  end
end
