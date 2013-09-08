class AddColumnProduct3 < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
      ADD access varchar(8) default 'Public';
    SQL
  end

  def down
  end
end
