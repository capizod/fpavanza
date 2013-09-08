class AddForeignProductStatePro < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
        ADD CONSTRAINT fk_products_product_state
        FOREIGN KEY (product_state_id)
        REFERENCES product_states(id);
    SQL
  end

  def down
  end
end
