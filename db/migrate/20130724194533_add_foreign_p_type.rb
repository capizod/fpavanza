class AddForeignPType < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE product_packages
        ADD CONSTRAINT fk_products_packages_type
        FOREIGN KEY (product_type_id)
        REFERENCES product_types(id);
    SQL
  end

  def down
  end
end
