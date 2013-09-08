class ModifyColumnProduct < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products 
      MODIFY COLUMN provider_type_id int(10) NULL;
    SQL
  end

  def down
  end
end
