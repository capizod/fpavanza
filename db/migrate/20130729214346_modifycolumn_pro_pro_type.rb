class ModifycolumnProProType < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products 
      MODIFY COLUMN product_type_id int(10) NOT NULL;
    SQL
  end

  def down
  end
end
