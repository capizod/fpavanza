class AddFieldPTypeToPro < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
        ADD provider_type_id int(18) NOT NULL;        
    SQL
  end

  def down
  end
end
