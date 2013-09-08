class CreateCapacityTcs < ActiveRecord::Migration
  def change
    create_table :capacity_tcs do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end
end
