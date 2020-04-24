# frozen_string_literal: true

RSpec.describe Api::V1.tasksController, type: :request do
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  let(:task) { create(:task, status: 'delivered', provider: provider, user: user) }
  let!(:task_items) { 5.times { create(:task_item, task: task) } }


  describe 'Successessfully' do
    describe 'DELETE /api/v1/task/id' do
      before do
        delete "/api/v1/tasks/#{task.id}",
         headers: admin_headers
      end

      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end
  
      it 'Requester is able to delete his request.' do
        expect(json_response['message']).to eq 'task successfully deleted'
      end
    end
  end
end
