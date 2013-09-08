class AddColumnCapAcc < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE capacities
      ADD access varchar(8) default 'Public';
    SQL
  end

  def down
  end
end
