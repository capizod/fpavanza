class AddCCapTe < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE capacity_tes
      ADD name varchar(255) not null;
    SQL
  end

  def down
  end
end
