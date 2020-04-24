# frozen_string_literal: true

RSpec.describe 'PUT api/v1/tasks/:id', type: :request do
  let(:provider) { create(:user) }
  let(:provider_credentials) { provider.create_new_auth_token }
  let(:provider_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(provider_credentials) }

  let(:task) { create(:task, status: 'claimed', provider: provider ) }
  let!(:task_items) { 5.times { create(:task_item, task: task) } }

  describe 'Succesfully declines a task' do
    before do
      put "/api/v1/profiles/#{task.id}",
          params: { activity: 'confirmed' },
          headers: provider_headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'response with success message' do
      expect(response_json['message']).to eq 'Your claimed task has been declined'
    end
  end

  describe 'Unsuccessfully' do
    let(:another_provider) { create(:user) }
    let(:another_provider_credentials) { another_provider.create_new_auth_token }
    let(:another_provider_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(another_provider_credentials) }
  
    describe 'Another provider tries to decline a task' do
      before do
        put "/api/v1/profiles/#{task.id}",
            params: { activity: 'confirmed' },
            headers: another_provider_headers
      end

      it 'returns a 401 response status' do
        expect(response).to have_http_status 401
      end

      it 'response with error message' do
        expect(response_json['error_message']).to eq 'You are not authorized for this action.'
      end
    end

    describe 'Provider tries to decline a task that is delivered' do
      let(:delivered_task) { create(:task, status: 'delivered', provider: provider ) }

      before do
        put "/api/v1/profiles/#{delivered_task.id}",
            params: { activity: 'confirmed' },
            headers: provider_headers
      end

      it 'returns a 401 response status' do
        expect(response).to have_http_status 401
      end

      it 'response with error message' do
        expect(response_json['error_message']).to eq 'You are not authorized for this action.'
      end
    end
  end
end
