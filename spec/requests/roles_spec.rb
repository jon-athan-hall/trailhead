require 'rails_helper'

RSpec.describe 'Roles API', type: :request do
  # GET /roles
  describe 'GET /Roles' do
    before :each do
      FactoryBot.create_list(:role, 3)
      get roles_url, as: :json
    end

    it 'returns data' do
      expect(json['data'].size).to eq(3)
    end

    include_examples 'status code', 200
  end

  # GET /roles/:id
  describe 'GET /roles/:id' do
    before :each do
      @r = FactoryBot.create(:role)
      get role_url(@r), as: :json
    end

    it 'returns data' do
      expect(json['data']['name']).to eq(@r.name)
    end

    include_examples 'status code', 200
  end

  # POST /roles
  describe 'POST /roles' do
    let(:valid_params) {
      {
        name: 'default',
      }
    }

    before :each do
      post roles_url, params: { role: valid_params }, as: :json
      @r = Role.find_by(name: valid_params[:name])
    end

    it 'adds the role to the database' do
      expect(@r).to be_present
    end

    it 'returns data' do
      expect(json['data']['name']).to eq(@r.name)
    end

    include_examples 'status code', 201
  end

  # PATCH /roles/:id
  describe 'PATCH /roles/:id' do
    let(:valid_params) {
      {
        name: 'basic'
      }
    }

    before :each do
      @r = FactoryBot.create(:role)
      patch role_url(@r), params: { role: valid_params }, as: :json
    end

    it 'updates the role in the database' do
      expect(Role.find(@r.id).name).to eq(valid_params[:name])
    end

    it 'returns data' do
      expect(json['data']['name']).to eq(valid_params[:name])
    end

    include_examples 'status code', 202
  end

  # DELETE /roles/:id
  describe 'DELETE /roles/:id' do
    before :each do
      @r = FactoryBot.create(:role)
      delete role_url(@r), as: :json
    end

    it 'removes the role from the database' do
      # Needs to be in a block for testing errors.
      expect { Role.find(@u.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    include_examples 'status code', 200
  end
end
