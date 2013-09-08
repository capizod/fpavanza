class AddForeignProviderProduct < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE products
        ADD CONSTRAINT fk_products_provider
        FOREIGN KEY (provider_id)
        REFERENCES providers(id);
    SQL
  end

  def down
  end
end
