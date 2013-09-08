class CreateBranches < ActiveRecord::Migration
  def up
    create_table :branches do |t|
      t.string :name
      t.references :bank, :null => false
      t.timestamps
    end
  end
  
  def down
    drop_table :branches
  end
end
