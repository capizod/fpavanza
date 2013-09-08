class AddColumnContrPro < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
      ADD monto_mex decimal(16,2) default 0;
    SQL
  end

  def down
  end
end
