require "rails_helper"

RSpec.describe "Api::V1::TasksController", type: :request do
  let!(:product_1) {create(:product, name: "pasta", price: 20)}
  let!(:product_2) {create(:product, name: "eggs", price: 30)}
  let!(:product_3) {create(:product, name: "tomatoes", price: 10)}

  before do 
    post "/api/v1/tasks", params: {product_id: product_1.id}
  end

  describe "POST api/v1/tasks" do

  it "response with succes message" do
    expect((response_json)["message"]).to eq "The product has been added to your request"
  end

  it "response with task ID" do
    expect((response_json)["task"]["id"]).to eq task.id
  end

  it "response with task right amount of products" do
    expect((response_json)["task"]["products"]).to eq 1
  end

  it "response with the right total amount" do
    expect((response_json)["task"]["total"]).to eq 20
  end
end

describe "PUT api/v1/tasks/:id" do
  before do 
    put "/api/v1/tasks/#{task.id}", params: {product_id: product_2.id}
    put "/api/v1/tasks/#{task.id}", params: {product_id: product_2.id}
    put "/api/v1/tasks/#{task.id}", params: {product_id: product_3.id}
  end

  it "response with succes message" do
    expect((response_json)["message"]).to eq "The product has been added to your request"
  end

  it "response with task ID" do
    expect((response_json)["task"]["id"]).to eq task.id
  end

  it "response with task right amount of products" do
    expect((response_json)["task"]["products"]).to eq 4
  end

  it "response with the right total amount" do
    expect((response_json)["task"]["total"]).to eq 100
  end
end

end