class AddForeignFieldGroupTag < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE field_groups
        ADD CONSTRAINT fk_contacts_lead_tag
        FOREIGN KEY (tag_id)
        REFERENCES tags(id)
    SQL
  end

  def down
  end
end
