class AddForeignUserContact < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE contacts
        ADD CONSTRAINT fk_contact_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def down
  end
end
