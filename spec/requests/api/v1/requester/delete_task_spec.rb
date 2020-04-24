# frozen_string_literal: true

RSpec.describe 'Api::V1::TasksController', type: :request do
  let!(:user) { create(:user) }
  let!(:user_credentials) { user.create_new_auth_token }
  let!(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'Successessfully' do
    describe 'User can delete his confirmed task.' do
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
        expect(response_json['message']).to eq 'Your request has been successfully deleted.'
      end
    end

    describe 'User can delete his pending task.' do
      let!(:task) { create(:task, status: 'pending', user: user) }
      let!(:task_items) { 5.times { create(:task_item, task: task) } }
  
      before do
        delete "/api/v1/tasks/#{task.id}",
         headers: user_headers
      end

      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end
  
      it 'Requester is able to delete his request.' do
        expect(response_json['message']).to eq 'Your request has been successfully deleted.'
      end
    end
  end

  describe 'Unccessessfully' do
    let!(:another_user) { create(:user) }
    let!(:another_user_credentials) { another_user.create_new_auth_token }
    let!(:another_user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(another_user_credentials) }

    describe 'User cannot delete his claimed task.' do
      let!(:task) { create(:task, status: 'claimed', user: user) }
      let!(:task_items) { 5.times { create(:task_item, task: task) } }
  
      before do
        delete "/api/v1/tasks/#{task.id}",
         headers: user_headers
      end

      it 'returns a 401 response status' do
        expect(response).to have_http_status 401
      end
  
      it 'Requester is able to delete his request.' do
        expect(response_json['error_message']).to eq 'You are not authorized to perform this action.'
      end
    end

  
    describe 'User tries to delete  another user request order.' do
      let!(:task) { create(:task, status: 'confirmed', user: user) }
      let!(:task_items) { 5.times { create(:task_item, task: task) } }
  
      before do
        delete "/api/v1/tasks/#{task.id}",
         headers: another_user_headers
      end

      it 'returns a 401 response status' do
        expect(response).to have_http_status 401
      end
  
      it 'Requester is able to delete his request.' do
        expect(response_json['error_message']).to eq 'You are not authorized to perform this action.'
      end
    end
  end
end
