# frozen_string_literal: true

RSpec.describe "PUT api/v1/tasks/:id", type: :request do
  let(:provider) { create(:user) }
  let(:provider_credentials) { provider.create_new_auth_token }
  let(:provider_headers) { { HTTP_ACCEPT: "application/json" }.merge!(provider_credentials) }

  # let(:user) { create(:user) }
  # let(:user_credentials) { user.create_new_auth_token }
  # let(:user_headers) { { HTTP_ACCEPT: "application/json" }.merge!(user_credentials) }

  let(:other_provider) { create(:user) }
  let(:other_provider_credentials) { other_provider.create_new_auth_token }
  let(:other_provider_headers) { { HTTP_ACCEPT: "application/json" }.merge!(other_provider_credentials) }

  let(:task) { create(:task, status: "confirmed") }
  let!(:task_items) { 5.times { create(:task_item, task: task) } }

  describe "Succesfully claims task" do
    before do
      put "/api/v1/tasks/#{task.id}",
          params: { activity: "claimed" },
          headers: provider_headers
    end

    it "returns a 200 response status" do
      expect(response).to have_http_status 200
    end

    it "response with success message" do
      expect(response_json["message"]).to eq "You claimed the task"
    end

    it "task contains provider id" do
      expect(Task.last.provider_id).to eq provider.id
    end
  end

  describe "Unsuccessfully claims task" do
    let(:task) { create(:task, user: provider, status: "confirmed") }
    let!(:task_items) { 5.times { create(:task_item, task: task) } }

    describe "User cannot claim his own task" do
      before do
        put "/api/v1/tasks/#{task.id}",
            params: { activity: "claimed" },
            headers: provider_headers
      end

      it "returns a 405 response status" do
        expect(response).to have_http_status 405
      end

      it "returns error message on claiming own task" do
        expect(response_json["error_message"]).to eq "You cannot claim your own task"
      end
    end

    describe "User cannot claim task with status: claimed" do
      let(:task) { create(:task, status: "claimed", provider: provider) }
      let!(:task_items) { 5.times { create(:task_item, task: task) } }
      before do
        put "/api/v1/tasks/#{task.id}",
            params: { activity: "claimed" },
            headers: other_provider_headers
      end

      it "returns a 409 response status" do
        expect(response).to have_http_status 409
      end

      it "returns error message" do
        expect(response_json['error_message']).to eq "Task has already been claimed!"
      end
    end
  end
end
