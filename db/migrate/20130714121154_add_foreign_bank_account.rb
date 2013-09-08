class AddForeignBankAccount < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE bank_accounts
        ADD CONSTRAINT fk_bank_accounts_acc
        FOREIGN KEY (account_id)
        REFERENCES accounts(id)
    SQL
  end

  def down
  end
end
