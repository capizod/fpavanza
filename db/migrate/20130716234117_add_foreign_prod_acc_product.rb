class AddForeignProdAccProduct < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE account_products
        ADD CONSTRAINT fk_product_acc_product
        FOREIGN KEY (product_id)
        REFERENCES products(id);
    SQL
  end

  def down
  end
end
