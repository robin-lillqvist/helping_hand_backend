require "rails_helper"

RSpec.describe "Api::V1::TasksController", type: :request do
  let!(:product_1) { create(:product, name: "pasta", price: 20) }
  let!(:product_2) { create(:product, name: "eggs", price: 30) }
  let!(:product_3) { create(:product, name: "tomatoes", price: 10) }
  let!(:tasks) { create(:task) }

  before do
    post "/api/v1/tasks", params: { product_id: product_1.id }
    task_id = (response_json)["task"]["id"]
    @task = Task.find(task_id)
  end

  before do
    tasks.task_items.create(product: product_1)
    tasks.task_items.create(product: product_2)
    tasks.task_items.create(product: product_3)
    put "/api/v1/tasks/#{@task.id}", params: { activity: "confirmed" }
  end

  describe "GET /tasks" do
    before do
      get "/api/v1/tasks"
    end

    it "returns a 200 response status" do
      expect(response).to have_http_status 200
    end
  end
end
