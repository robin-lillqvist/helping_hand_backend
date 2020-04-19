# frozen_string_literal: true

RSpec.describe "PUT api/v1/tasks/:id", type: :request do
  let(:provider) { create(:user) }
  let(:provider_credentials) { provider.create_new_auth_token }
  let(:provider_headers) { { HTTP_ACCEPT: "application/json" }.merge!(provider_credentials) }

  let(:task) { create(:task, status: "claimed", provider: provider) }
  let!(:task_items) { 5.times { create(:task_item, task: task) } }

  describe "Succesfully delivers task" do
    before do
      put "/api/v1/tasks/#{task.id}",
        params: { activity: "delivered" },
        headers: provider_headers
    end

    it "returns a 200 response status" do
      expect(response).to have_http_status 200
    end

    it "response with success message" do
      expect(response_json["message"]).to eq "Thank you for your help!"
    end
  end

  describe "Unsuccesfully delivers task" do
    let(:another_provider) { create(:user) }
    let(:another_provider_credentials) { another_provider.create_new_auth_token }
    let(:another_provider_headers) { { HTTP_ACCEPT: "application/json" }.merge!(another_provider_credentials) }

    describe "Another provider tries to deliver task" do
      before do
        put "/api/v1/tasks/#{task.id}",
          params: { activity: "delivered" },
          headers: another_provider_headers
      end

      it "returns a 400 response status" do
        expect(response).to have_http_status 401
      end

      it "response with unauthorized message" do
        expect(response_json["error_message"]).to eq "You haven't claimed this task, please contact support."
      end
    end
  end
end
