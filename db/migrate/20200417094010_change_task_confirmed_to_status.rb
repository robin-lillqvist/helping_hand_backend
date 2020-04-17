class ChangeTaskConfirmedToStatus < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :confirmed
    add_column :tasks, :status, :integer, default: 0
  end
end
