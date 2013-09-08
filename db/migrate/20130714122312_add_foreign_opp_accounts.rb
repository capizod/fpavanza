class AddForeignOppAccounts < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE account_opportunities
        ADD CONSTRAINT fk_account_opportunities_opp
        FOREIGN KEY (opportunity_id)
        REFERENCES opportunities(id)
    SQL
  end

  def down
  end
end
