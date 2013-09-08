class AddColumnInternalIdUsers < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE users
      ADD consultant_key int(10)
    SQL
  end

  def down
  end
end
