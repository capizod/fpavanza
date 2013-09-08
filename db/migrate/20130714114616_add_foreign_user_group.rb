class AddForeignUserGroup < ActiveRecord::Migration
  def up
     # add a foreign key
    execute <<-SQL
      ALTER TABLE groups_users
        ADD CONSTRAINT fk_groups_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def down
  end
end
