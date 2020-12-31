require 'rails_helper'

# Watch for false positives in all tests!
RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  before :each do
    # Use "create" to persist the user in the database, and
    # make sure it's an instance variable.
    @u = User.create(
      name: "Jonathan",
      email: "jonathan@codeandcardboard.com",
      password: "whatever",
      password_confirmation: "whatever"
    )
  end

  context "when all parameters are valid" do
    it "validates successfully" do
      expect(@u).to be_valid
    end

    it "saves to the database" do
      expect(User.where(email: @u.email)).to exist
    end
  end

  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without a password confirmation" do
    user = FactoryBot.build(:user, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    # Use 'create' to persist the first user in the database.
    FactoryBot.create(:user, email: 'test@test.com')
    user = FactoryBot.build(:user, email: 'test@test.com')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid with an incorrect email format" do
    user = User.new(
      name: "Jonathan",
      email: "jonathancom",
      password: "whatever",
      password_confirmation: "whatever"
    )
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it "is invalid with a short password" do
    user = User.new(
      name: "Jonathan",
      email: "jonathancom",
      password: "wut",
      password_confirmation: "wut"
    )
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "is invalid if password and password_confirmation do not match" do
    user = User.new(
      name: "Jonathan",
      email: "jonathan@codeandcardboard.com",
      password: "whatever",
      password_confirmation: "whenever"
    )
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "cleans up the email address before creation" do
    user = FactoryBot.create(:user, email: "jonaThAn@coDe and card boa rd.com")
    expect(user.email).to eq("jonathan@codeandcardboard.com")
  end
end
