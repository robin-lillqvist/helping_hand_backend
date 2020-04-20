RSpec.describe "PUT api/v1/tasks/:id", type: :request do
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: "application/json" }.merge!(user_credentials) }

  let(:task) { create(:task, status: "delivered") }
  let!(:task_items) { 5.times { create(:task_item, task: task) } }

  describe "Succesfully finalizes the task" do
    before do
      put "/api/v1/tasks/#{task.id}",
        params: { activity: "finalized" },
        headers: user_headers
    end

    it "returns a 200 response status" do
      expect(response).to have_http_status 200
    end

    it "response with success message" do
      binding.pry
      expect(response_json["message"]).to eq "You finalized the delivery"
    end
  end
end
