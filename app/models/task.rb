class Task < ApplicationRecord
  has_many :task_items

  def order_total
    task_items.joins(:product).sum("products.price")
  end
end
