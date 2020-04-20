RSpec.describe Api::V1::TasksController, type: :request do
  
    describe' GET /task/id successfully' do
      let(:task) { create(:task, status: 'confirmed') }
      let!(:task_items) { 5.times { create(:task_item, task: task) } }

      before do
        get "/api/v1/tasks/#{task.id}"
      end
  
      it 'should return a 200 response' do
        expect(response).to have_http_status 200
      end

      it 'should return task id' do
        expect(response_json['id']).to eq task.id
      end

      it 'should return status' do
        expect(Task.last.status).to eq 'confirmed'
      end
    end

    describe' GET /task/id unsuccessfully' do
      let(:task) { create(:task, status: 'delivered') }
      let!(:task_items) { 5.times { create(:task_item, task: task) } }

      before do
        get "/api/v1/tasks/#{task.id}"
      end
  
      it 'should return a 404 response' do
        expect(response).to have_http_status 404
      end

      it 'should return task id' do
        expect(response_json['message']).to eq "The task you are searching for does not exist" 
      end
    end
  end 