class AddAccAccountTypeId < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE accounts
        ADD account_type_id int(10)        
    SQL
  end

  def down
  end
end
