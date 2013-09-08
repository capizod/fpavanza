class AddForeignGroupUsersG < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE groups_users
        ADD CONSTRAINT fk_groups_users_group
        FOREIGN KEY (group_id)
        REFERENCES groups(id)
    SQL
  end

  def down
  end
end
