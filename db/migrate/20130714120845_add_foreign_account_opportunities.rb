class AddForeignAccountOpportunities < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE account_opportunities
        ADD CONSTRAINT fk_account_opportunies_acc
        FOREIGN KEY (account_id)
        REFERENCES accounts(id)
    SQL
  end

  def down
  end
end
