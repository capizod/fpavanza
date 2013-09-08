class CreateCreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :create_bank_accounts do |t|
      t.string :bank_key

      t.timestamps
    end
  end
end
