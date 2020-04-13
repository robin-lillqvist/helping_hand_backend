require "rails_helper"

RSpec.describe "Api::V1::TasksController", type: :request do
  let!(:product_1) {create(:product, name: "pasta")}
  let!(:product_2) {create(:product, name: "eggs")}
  let!(:product_3) {create(:product, name: "tomatoes")}

  before do 
    post "/api/v1/tasks", params: {product_id: product_1.id}
  end

  it "response with succes message" do
    expect(response_json["message"]).to eq "The product has been added to your request"
  end
end