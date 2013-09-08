class DropAccType < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE accounts
        DROP account_type        
    SQL
  end

  def down
  end
end
