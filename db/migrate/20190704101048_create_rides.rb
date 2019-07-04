class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :code
      t.string :from
      t.string :to
      t.string :state

      t.timestamps
    end
  end
end
