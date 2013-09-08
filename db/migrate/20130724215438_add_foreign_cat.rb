class AddForeignCat < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE product_types
        ADD CONSTRAINT fk_products_cat_ptype
        FOREIGN KEY (product_category_id)
        REFERENCES product_categories(id);
    SQL
  end

  def down
  end
end
