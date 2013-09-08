class AddForeignPermissionGroup < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE permissions
        ADD CONSTRAINT fk_permissions_group
        FOREIGN KEY (group_id)
        REFERENCES groups(id)
    SQL
  end

  def down
  end
end
