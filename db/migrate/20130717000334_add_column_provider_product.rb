class AddColumnProviderProduct < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
        ADD provider_id int(10);
    SQL
  end

  def down
  end
end
