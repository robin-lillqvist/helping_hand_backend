require 'rails_helper'

RSpec.describe Task, type: :model do

  it "should have valid factory" do
    expect(create(:product)).to be_valid
  end
  
  describe "Database table" do
    it { is_expected.to have_db_column :confirmed }
  end
  
  it { is_expected.to have_many :task_items }
end

