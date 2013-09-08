class AddForeignAccAccTypes < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE accounts
        ADD CONSTRAINT fk_acc_account_type
        FOREIGN KEY (account_type_id)
        REFERENCES account_types(id)
    SQL
  end

  def down
  end
end
