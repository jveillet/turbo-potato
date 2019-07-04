class AddIndexToRide < ActiveRecord::Migration[5.2]
  def change
    add_index :rides, :code, unique: true
  end
end
