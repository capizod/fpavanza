class CreateAccountTypes < ActiveRecord::Migration
  def up
    create_table :account_types do |t|
      t.string :name, :null => false
      
      t.timestamps
    end
  end
  def down
    drop_table :account_types
  end
end
