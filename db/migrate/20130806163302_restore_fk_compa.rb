class RestoreFkCompa < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE accounts
        ADD CONSTRAINT fk_acc_companies
        FOREIGN KEY (company_id)
        REFERENCES companies(id)
    SQL
  end

  def down
  end
end
