class AddForeignPtPro < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
        ADD CONSTRAINT fk_products_provider_typ
        FOREIGN KEY (provider_type_id)
        REFERENCES provider_types(id);
    SQL
  end

  def down
  end
end
