class AddColumnsProduct2 < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
      ADD assigned_to int(10);
    SQL
  end

  def down
  end
end
