class AddForeignFieldGroups < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE fields
        ADD CONSTRAINT fk_fields_fld_group
        FOREIGN KEY (field_group_id)
        REFERENCES field_groups(id)
    SQL
  end

  def down
  end
end
