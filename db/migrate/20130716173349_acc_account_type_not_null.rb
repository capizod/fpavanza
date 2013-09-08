class AccAccountTypeNotNull < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE accounts
        MODIFY account_type_id int(10) NOT NULL        
    SQL
  end

  def down
  end
end
