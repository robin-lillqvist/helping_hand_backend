# frozen_string_literal: true

RSpec.describe 'Api::V1::TasksController', type: :request do
  let!(:product_1) { create(:product, name: 'pasta', price: 20) }
  let!(:product_2) { create(:product, name: 'eggs', price: 30) }
  let!(:product_3) { create(:product, name: 'tomatoes', price: 10) }
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'User succeffully creates a task ' do
    before do
      post '/api/v1/tasks',
           params: {
             product_id: product_1.id,
             user_id: user.id,
             lat: 25.76,
             long: 80.19
           },
           headers: user_headers
      task_id = response_json['task']['id']
      @task = Task.find(task_id)
    end

    it 'response with succes message' do
      expect(response_json['message']).to eq 'The product has been added to your request'
    end

    it 'response with task ID' do
      expect(response_json['task']['id']).to eq @task.id
    end

    it 'response with task right amount of products' do
      expect(response_json['task']['products'][0]['amount']).to eq 1
    end

    it 'response with the right total amount' do
      expect(response_json['task']['total']).to eq '20.0'
    end

    describe 'User can update the task' do
      before do
        3.times { put "/api/v1/tasks/#{@task.id}", params: { product_id: product_2.id }, headers: user_headers }
      end

      it 'response with succes message' do
        expect(response_json['message']).to eq 'The product has been added to your request'
      end

      it 'response with task ID' do
        expect(response_json['task']['id']).to eq @task.id
      end

      it 'response with task right amount of products' do
        expect(response_json['task']['products'][1]['amount']).to eq 3
      end

      it 'response with the right total amount' do
        expect(response_json['task']['total']).to eq '110.0'
      end

      it 'response contains long and lat' do
        expect(response_json['task']['long']).to eq "80.19"
        expect(response_json['task']['lat']).to eq "25.76"
      end
    end
  end

  describe 'Unsuccessfull' do
    describe 'when user has a confirmed task' do
      let(:confirmed_task) { create(:task, user: user, status: 'confirmed') }
      let!(:task_items) { 5.times { create(:task_item, task: confirmed_task) } }
      before do
        post '/api/v1/tasks',
             params: {
               product_id: product_1.id,
               user_id: user.id
             },
             headers: user_headers
      end

      it 'returns a 403 response' do
        expect(response).to have_http_status 403
      end

      it 'response with error message' do
        expect(response_json['error']).to eq 'You can only have one active task at a time.'
      end
    end
  end
end
