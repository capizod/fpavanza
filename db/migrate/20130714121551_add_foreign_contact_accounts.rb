class AddForeignContactAccounts < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE account_contacts
        ADD CONSTRAINT fk_account_contacts_cacts
        FOREIGN KEY (contact_id)
        REFERENCES contacts(id)
    SQL
  end

  def down
  end
end
