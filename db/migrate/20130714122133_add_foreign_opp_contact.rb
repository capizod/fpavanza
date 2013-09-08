class AddForeignOppContact < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE contact_opportunities
        ADD CONSTRAINT fk_contact_opportunities_opp
        FOREIGN KEY (opportunity_id)
        REFERENCES opportunities(id)
    SQL
  end

  def down
  end
end
