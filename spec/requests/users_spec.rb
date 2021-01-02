require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # GET /users
  describe 'GET /users' do
    before :each do
      FactoryBot.create_list(:user, 3)
      get users_url, as: :json
    end

    it 'returns data' do
      expect(json['data'].size).to eq(3)
    end

    include_examples 'status code', 200
  end

  # GET /users/:id
  describe 'GET /users/:id' do
    before :each do
      @u = FactoryBot.create(:user)
      get user_url(@u), as: :json
    end

    it 'returns data' do
      expect(json['data']['email']).to eq(@u.email)
    end

    include_examples 'status code', 200
  end

  # POST /users
  describe 'POST /users' do
    let(:valid_params) {
      {
        name: 'Tester',
        email: 'tester@test.com',
        password: 'whatever',
        password_confirmation: 'whatever'
      }
    }

    before :each do
      post users_url, params: { user: valid_params }, as: :json
      @u = User.find_by(email: valid_params[:email])
    end

    it 'adds the user to the database' do
      expect(@u).to be_present
    end

    it 'creates a confirmation token' do
      expect(@u.confirmation_token).to be_present
    end

    it 'returns data' do
      expect(json['data']['email']).to eq(@u.email)
    end

    include_examples 'status code', 201
  end

  # PATCH /users/:id
  describe 'PATCH /users/:id' do
    let(:valid_params) {
      {
        name: 'changer'
      }
    }

    before :each do
      @u = FactoryBot.create(:user)
      patch user_url(@u), params: { user: valid_params }, as: :json
    end

    it 'updates the user in the database' do
      expect(User.find(@u.id).name).to eq(valid_params[:name])
    end

    it 'returns data' do
      expect(json['data']['name']).to eq(valid_params[:name])
    end

    include_examples 'status code', 202
  end

  # DELETE /users/:id
  describe 'DELETE /users/:id' do
    before :each do
      @u = FactoryBot.create(:user)
      delete user_url(@u), as: :json
    end

    it 'removes the user from the database' do
      # Needs to be in a block for testing errors.
      expect { User.find(@u.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    include_examples 'status code', 200
  end

  # POST /users/confirm/:token
  describe 'POST /users/confirm/:token' do
    before :each do
      @u = FactoryBot.create(:user)
      post confirm_users_url, params: { token: @u.confirmation_token }
      @u.reload
    end

    it 'removes the confirmation token from the database' do
      expect(@u.confirmation_token).to be_nil
    end

    it 'creates a confirmation date' do
      expect(@u.confirmed_at).to be_present
    end

    include_examples 'status code', 202
  end
end
