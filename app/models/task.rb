class Task < ApplicationRecord
  has_many :task_items
  belongs_to :user
end
