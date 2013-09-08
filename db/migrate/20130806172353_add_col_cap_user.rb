class AddColCapUser < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE capacities
      ADD user_id int(10);
    SQL
  end

  def down
  end
end
