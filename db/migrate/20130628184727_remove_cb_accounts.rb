class RemoveCbAccounts < ActiveRecord::Migration
  def up
     execute <<-SQL
      DROP TABLE create_bank_accounts
    SQL
  end

  def down
  end
end
