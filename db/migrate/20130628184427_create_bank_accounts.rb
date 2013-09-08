class CreateBankAccounts < ActiveRecord::Migration
  def up
    create_table :bank_accounts do |t|
      t.references :account, :null => false
      t.references :bank, :null => false
      t.string :bank_key, :limit => 3
      t.string :bank_plaza, :limit => 3
      t.string :account_number, :limit => 11
      t.string :control_digit, :limit => 1
      t.timestamps
    end
  end
  def down
    drop_table :bank_accounts
  end
end
