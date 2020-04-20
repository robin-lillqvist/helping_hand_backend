# frozen_string_literal: true

RSpec.describe 'Api::V1::ProfilesController', type: :request do
  let(:user) { create(:user) }

  let(:provider) { create(:user) }
  let(:provider_credentials) { provider.create_new_auth_token }
  let(:provider_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(provider_credentials) }

  let(:task) { create(:task, status: 'claimed', provider: provider, user: user) }
  let!(:task_items) { 5.times { create(:task_item, task: task) } }

  let(:another_task) { create(:task, status: 'claimed', provider: provider, user: user) }
  let!(:another_task_items) { 5.times { create(:task_item, task: another_task) } }

  describe 'Successfully' do
    describe 'GET /profiles' do
      before do
        get '/api/v1/profiles',
            headers: provider_headers
      end

      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'returns a list of claimed tasks' do
        expect(response_json.count).to eq 2
      end

      it 'returns the correct provider id' do
        expect(response_json.first['provider_id']).to eq provider.id
        expect(response_json.last['provider_id']).to eq provider.id
      end
    end

    describe' GET /profiles unsuccessfully' do
      let(:another_provider) { create(:user) }
      let(:another_provider_credentials) { another_provider.create_new_auth_token }
      let(:another_provider_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(another_provider_credentials) }
    
      before do
        get '/api/v1/profiles',
            headers: another_provider_headers
      end
  
      it 'should return a 401 response' do
        expect(response).to have_http_status 401
      end

      it 'should return task id' do
        expect(response_json['error_message']).to eq "Error" 
      end
    end
  end
end
