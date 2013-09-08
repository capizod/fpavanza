class AddForeignAccountContacts < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE account_contacts
        ADD CONSTRAINT fk_account_contacts
        FOREIGN KEY (account_id)
        REFERENCES accounts(id)
    SQL
  end

  def down
  end
end
