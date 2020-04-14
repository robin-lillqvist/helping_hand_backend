class AddConfirmTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :confirmed, :boolean, default: false
  end
end
