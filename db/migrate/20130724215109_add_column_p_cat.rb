class AddColumnPCat < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE product_types
        ADD product_category_id int(18) NOT NULL;        
    SQL
  end

  def down
  end
end
