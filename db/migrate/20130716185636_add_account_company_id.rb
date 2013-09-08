class AddAccountCompanyId < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE accounts
      ADD company_id int(18)
    SQL
  end

  def down
  end
end
