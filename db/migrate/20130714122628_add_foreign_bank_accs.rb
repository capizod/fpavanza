class AddForeignBankAccs < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE bank_accounts
        ADD CONSTRAINT fk_bank_accounts_opp
        FOREIGN KEY (bank_id)
        REFERENCES banks(id)
    SQL
  end

  def down
  end
end
