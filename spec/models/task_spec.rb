require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to have_many :task_items }
end
