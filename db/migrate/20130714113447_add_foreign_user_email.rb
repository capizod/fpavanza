class AddForeignUserEmail < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE emails
        ADD CONSTRAINT fk_email_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def down
  end
end
