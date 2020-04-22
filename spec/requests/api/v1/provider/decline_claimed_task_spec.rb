# frozen_string_literal: true

RSpec.describe "PUT api/v1/tasks/:id", type: :request do
  let(:provider) { create(:user) }
  let(:provider_credentials) { provider.create_new_auth_token }
  let(:provider_headers) { { HTTP_ACCEPT: "application/json" }.merge!(provider_credentials) }

  let(:task) { create(:task, status: "claimed", user: provider) }
  let!(:task_items) { 5.times { create(:task_item, task: task) } }

  describe "Succesfully declines a task" do
    before do
      put "/api/v1/profiles/#{task.id}",
          params: { activity: "confirmed" },
          headers: provider_headers
    end

    it "response with success message" do
         expect(response_json["message"]).to eq "Your claimed task has been declined"
    end

  end
end
