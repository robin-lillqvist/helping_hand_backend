# frozen_string_literal: true

RSpec.describe 'Api::V1::ProfilesController', type: :request do

  describe 'Successfully' do
    describe 'User can view his profile.' do
      let(:user) { create(:user) }
      let(:user_credentials) { user.create_new_auth_token }
      let(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

      let!(:task) { create(:task, user: user) }
      let!(:another_task) { create(:task, user: user) }

      before do
        get "/api/v1/profiles/#{user.id}",
            headers: user_headers
      end

      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'user can see his information' do
        expect(response_json['email']).to eq "person2@example.com"
      end
    end
  end

  describe 'Unccessfully' do
    describe 'User can view his profile.' do
      let(:another_user) { create(:user) }
      let(:another_user_headers) { { HTTP_ACCEPT: 'application/json' } }

      let!(:task) { create(:task, user: another_user) }
      let!(:another_task) { create(:task, user: another_user) }

      before do
        get "/api/v1/profiles/#{another_user.id}",
            headers: another_user_headers
      end

      it 'returns a 401 response status' do
        expect(response).to have_http_status 401
      end

      it 'returns an error message' do
        expect(response_json['errors'].first).to eq "You need to sign in or sign up before continuing."
      end
    end
  end
end
