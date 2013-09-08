class AddColumnProduct < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
      ADD name varchar(255) not null
    SQL
  end

  def down
  end
end
