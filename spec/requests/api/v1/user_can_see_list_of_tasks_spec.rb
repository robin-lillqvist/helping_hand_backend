require "rails_helper"

RSpec.describe "Api::V1::TasksController", type: :request do
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: "application/json" }.merge!(user_credentials) }
  let!(:product) { create(:product) }

  before do
    post "/api/v1/tasks",
         params: {
           product_id: product.id,
           user_id: user.id,
         },
         headers: user_headers
    @task_id = (response_json)["task"]["id"]
    @task = Task.find(@task_id)
    put "/api/v1/tasks/#{@task.id}", params: { activity: "confirmed" }
    post "/api/v1/tasks",
         params: {
           product_id: product.id,
           user_id: user.id,
         },
         headers: user_headers
    @task_id = (response_json)["task"]["id"]
    @task_1 = Task.find(@task_id)
    put "/api/v1/tasks/#{@task_1.id}", params: { activity: "confirmed" }
  end

  describe "GET /tasks" do
    before do
      get "/api/v1/tasks"
    end

    it "returns a 200 response status" do
      expect(response).to have_http_status 200
    end

    it "returns correct number of tasks" do
      binding.pry
      expect(response_json.count).to eq 2
    end

    it "task contains a product" do
      expect(response_json[1]["products"][0]["amount"]).to eq 1
    end
  end
end
