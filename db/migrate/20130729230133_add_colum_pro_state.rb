class AddColumProState < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
      ADD COLUMN product_state_id int(10);
    SQL
  end

  def down
  end
end
