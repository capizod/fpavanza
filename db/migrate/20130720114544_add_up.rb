class AddUp < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
      ADD user_id int(10);
    SQL
  end

  def down
  end
end
