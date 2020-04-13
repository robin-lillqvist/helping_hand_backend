require 'rails_helper'

RSpec.describe Product, type: :model do
  it "should have valid factory" do
    expect(create(:product)).to be_valid
  end

  describe "Database table" do
    it {is_expected.to have_db_column :name}
    it {is_expected.to have_db_column :price}
  end

  describe "Validations" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :price}
  end

  describe "check if new product is being created" do
    before do
      @product1 = Product.new(name: "bread", price: 10)
    end
    it "expects to contain the product name" do
      expect(@product1.name).to eq("bread")
    end
    it "expects to contain the product price" do
      expect(@product1.price).to eq(10)
    end

  end
end
