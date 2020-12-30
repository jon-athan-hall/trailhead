require 'rails_helper'

# Be certain that the test code is doing what is intended, also
# known as exercising the code under test. Basically, watch for
# false positives.
#
# Use "describe" to outline general functionality.
# Use "context" to outline a specific state.
RSpec.describe User, type: :model do
  before :each do
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
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    # Persist the User in the test database.
    User.create(
      name: "Jonathan",
      email: "jonathan@codeandcardboard.com",
      password: "whatever",
      password_confirmation: "whatever"
    )
    user = User.new(
      name: "Alexandra",
      email: "jonathan@codeandcardboard.com",
      password: "whatever",
      password_confirmation: "whatever"
    )
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

  it "cleans up the email address before creation" do
    user = User.create(
      name: "Jonathan",
      email: "jonaThAn@coDe and card boa rd.com",
      password: "whatever",
      password_confirmation: "whatever"
    )
    expect(user.email).to eq("jonathan@codeandcardboard.com")
  end
end
