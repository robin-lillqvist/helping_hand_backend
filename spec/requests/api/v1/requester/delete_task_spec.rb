# frozen_string_literal: true

RSpec.describe 'Api::V1::TasksController', type: :request do
  let!(:user) { create(:user) }
  let!(:user_credentials) { user.create_new_auth_token }
  let!(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'Successessfully' do
    describe 'User can delete his order.' do
      let!(:task) { create(:task, status: 'confirmed', user: user) }
      let!(:task_items) { 5.times { create(:task_item, task: task) } }
  
      before do
        delete "/api/v1/tasks/#{task.id}",
         headers: user_headers
      end

      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end
  
      it 'Requester is able to delete his request.' do
        expect(response_json['message']).to eq 'Your task has been successfully delted'
      end
    end
  end
end
