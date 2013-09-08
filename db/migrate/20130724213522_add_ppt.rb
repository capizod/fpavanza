class AddPpt < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
        ADD product_type_id int(18) NOT NULL;        
    SQL
    
  end

  def down
  end
end
