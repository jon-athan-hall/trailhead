require 'rails_helper'

# Be certain that the test code is doing what it’s intended to do,
# also known as exercising the code under test. Basically, watch
# for false positives.
RSpec.describe User, type: :model do
  it "is valid with a name, email, and password" do
    user = User.new(
      name: "Jonathan",
      email: "jonathan@codeandcardboard.com",
      password: "whatever",
      password_confirmation: "whatever"
    )
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email"
  it "is invalid without a password"
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
end
