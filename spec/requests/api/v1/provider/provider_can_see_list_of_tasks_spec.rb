# frozen_string_literal: true

RSpec.describe 'Api::V1::TasksController', type: :request do
  let(:confirmed_task) { create(:task, status: 'confirmed') }
  let!(:confirmed_task_items) { 5.times { create(:task_item, task: confirmed_task) } }

  let(:another_confirmed_task) { create(:task, status: 'confirmed') }
  let!(:another_confirmed_task_items) { 5.times { create(:task_item, task: another_confirmed_task) } }

  let(:pending_task) { create(:task, status: 'pending') }
  let!(:pending_task_items) { 5.times { create(:task_item, task: pending_task) } }

  describe 'GET /tasks' do
    before do
      get '/api/v1/tasks'
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns correct number of tasks' do
      expect(response_json.count).to eq 2
    end

    it 'task contains five products' do
      expect(response_json[0]['products'].count).to eq 5
    end
  end
end
