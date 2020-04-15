require "rails_helper"

RSpec.describe "Api::V1::TasksController", type: :request do
  let!(:product_1) { create(:product, name: "pasta", price: 20) }
  let!(:product_2) { create(:product, name: "eggs", price: 30) }
  let!(:product_3) { create(:product, name: "tomatoes", price: 10) }
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: "application/json" }.merge!(user_credentials) }

  before do
    post "/api/v1/tasks",
      params: {
        task: {
          product_id: product_1.id,
          user_id: user.id
        }
      },
      headers: user_headers
      binding.pry
    task_id = (response_json)["task"]["id"]
    @task = Task.find(task_id)
  end

  describe "PUT api/v1/tasks/:id" do
    before do
      put "/api/v1/tasks/#{@task.id}", params: { product_id: product_2.id }
      put "/api/v1/tasks/#{@task.id}", params: { product_id: product_3.id }
      put "/api/v1/tasks/#{@task.id}", params: { activity: "confirmed" }
    end

    it "response with success message" do
      expect(response_json["message"]).to eq "Your task has been confirmed"
    end

    it "sets task attribute confirmed to true" do
      expect(@task.reload.confirmed).to eq true
    end
  end
end
