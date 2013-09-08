class AddAccountTypeToAcc < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE accounts
        ADD account_type int(10)        
    SQL
  end
end
