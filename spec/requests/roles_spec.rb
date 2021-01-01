require 'rails_helper'

RSpec.describe 'Roles API', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Role. As you add validations to Role, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      name: 'default'
    }
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # RolesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Role.create! valid_attributes
      get roles_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      role = Role.create! valid_attributes
      get role_url(role), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Role' do
        expect do
          post roles_url,
               params: { role: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Role, :count).by(1)
      end

      it 'renders a JSON response with the new role' do
        post roles_url,
             params: { role: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Role' do
        expect do
          post roles_url,
               params: { role: invalid_attributes }, as: :json
        end.to change(Role, :count).by(0)
      end

      it 'renders a JSON response with errors for the new role' do
        post roles_url,
             params: { role: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested role' do
        role = Role.create! valid_attributes
        patch role_url(role),
              params: { role: new_attributes }, headers: valid_headers, as: :json
        role.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the role' do
        role = Role.create! valid_attributes
        patch role_url(role),
              params: { role: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the role' do
        role = Role.create! valid_attributes
        patch role_url(role),
              params: { role: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested role' do
      role = Role.create! valid_attributes
      expect do
        delete role_url(role), headers: valid_headers, as: :json
      end.to change(Role, :count).by(-1)
    end
  end
end
