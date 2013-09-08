class AddForeignProductType < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
        DROP CONSTRAINT fk_product_product_type;
    SQL
  end

  def down
  end
end
