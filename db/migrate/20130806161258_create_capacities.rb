class CreateCapacities < ActiveRecord::Migration
  def change
    create_table :capacities do |t|
      t.integer     :capacity_emploee_id, :limit => 18, :null => false
      t.references  :capacity_tc, :null => false
      t.references  :region, :null => false
      t.decimal     :monto_mex, :precision => 16, :scale => 2, :null => false
      t.references  :city, :null => false
      t.date        :capacity_add_date
      t.references  :capacity_te, :null => false
      t.timestamps
    end
  end
end
