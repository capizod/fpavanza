class AddForeignLeadContacts < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE contacts
        ADD CONSTRAINT fk_contacts_lead
        FOREIGN KEY (lead_id)
        REFERENCES leads(id)
    SQL
  end

  def down
  end
end
