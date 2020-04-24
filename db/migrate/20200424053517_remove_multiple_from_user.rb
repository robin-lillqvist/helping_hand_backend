class RemoveMultipleFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role   
    remove_column :users, :image
    remove_column :users, :postcode
    remove_column :users, :city
  end
end
