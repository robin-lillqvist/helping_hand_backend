# frozen_string_literal: true

RSpec.describe 'Api::V1::ProfilesController', type: :request do
    let(:user) { create(:user) }
    let(:user_credentials) { user.create_new_auth_token }
    let(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }
  
    let(:provider) { create(:user) }
    let(:provider_credentials) { provider.create_new_auth_token }
    let(:provider_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(provider_credentials) }
  
  
    let(:task) { create(:task, status: 'claimed', provider: provider, user: user) }
    let!(:task_items) { 5.times { create(:task_item, task: task) } }
    
    describe 'GET /profiles' do
      before do
        get '/api/v1/profiles'
      end
  
      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end
  
    end
  end
  