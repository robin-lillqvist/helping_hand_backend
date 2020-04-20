RSpec.describe Api::V1::TasksController, type: :request do
    let(:task) { create(:task, status: 'confirmed') }
    let!(:task_items) { 5.times { create(:task_item, task: task) } }
  
    describe' GET /task/1 successfully' do
      before do
        get "/api/v1/tasks/#{task.id}"
      end
  
      it 'should return a 200 response' do
        expect(response).to have_http_status 200
      end
    end
  end 