class AddForeignTaggingsTag < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE taggings
        ADD CONSTRAINT fk_taggings_tag
        FOREIGN KEY (tag_id)
        REFERENCES tags(id)
    SQL
  end

  def down
  end
end
