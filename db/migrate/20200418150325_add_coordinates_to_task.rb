class AddCoordinatesToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :long, :decimal
    add_column :tasks, :lat, :decimal
  end
end
