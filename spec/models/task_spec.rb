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
    it { is_expected.to have_db_column :address }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :phone }
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

  describe 'check if task has phone/name/adress' do
    let(:task) { create(:task) }
    let!(:task_items) { 5.times { create(:task_item, task: task) } }

    it 'expects to contain the product name' do
      expect(Task.last.name).to eq 'Robin'
    end

    it 'expects to contain the product price' do
      expect(Task.last.address).to eq 'Bolidenvägen 12'
    end

    it 'expects to contain the product name' do
      expect(Task.last.phone).to eq '0729999999'
    end
  end
end
