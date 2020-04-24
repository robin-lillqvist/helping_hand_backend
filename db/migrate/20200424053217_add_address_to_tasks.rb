class AddAddressToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :address, :string
    add_column :tasks, :name, :string
    add_column :tasks, :phone, :string
  end
end