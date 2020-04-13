require 'rails_helper'

RSpec.describe Product, type: :model do
  it "should have valid factory" do
    expect(create(:product)).to be_valid
  end
end
