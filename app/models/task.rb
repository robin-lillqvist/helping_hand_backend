class Task < ApplicationRecord
  has_many :task_items
  belongs_to :user
  enum status: [:pending, :confirmed, :claimed, :finalized]

  def is_confirmable?
    task_items.count < 40 && task_items.count >= 5
  end

  def is_claimable?
    status != 'claimed'
  end
end
