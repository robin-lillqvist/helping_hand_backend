require 'rails_helper'

RSpec.describe TaskItem, type: :model do
  it { is_expected.to belong_to :task }
  it { is_expected.to belong_to :product }
end
