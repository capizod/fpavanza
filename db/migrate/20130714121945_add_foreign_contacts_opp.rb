class AddForeignContactsOpp < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE contact_opportunities
        ADD CONSTRAINT fk_contact_opportunities_cacts
        FOREIGN KEY (contact_id)
        REFERENCES contacts(id)
    SQL
  end

  def down
  end
end
