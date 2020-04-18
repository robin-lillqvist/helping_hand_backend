# frozen_string_literal: true

RSpec.describe Task, type: :model do
  it 'should have valid factory' do
    expect(create(:task)).to be_valid
  end

  describe 'Database table' do
    it { is_expected.to have_db_column :status }
    it { is_expected.to have_db_column :provider_id }
    it { is_expected.to have_db_column :long }
    it { is_expected.to have_db_column :lat }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :lat }
    it { is_expected.to validate_presence_of :long }
  end

  describe 'Associations' do
    it { is_expected.to have_many :task_items }
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to(:provider).optional(true) }
  end
end
