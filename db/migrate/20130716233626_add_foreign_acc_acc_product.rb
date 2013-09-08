class AddForeignAccAccProduct < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE account_products
        ADD CONSTRAINT fk_account_acc_product
        FOREIGN KEY (account_id)
        REFERENCES accounts(id);        
    SQL
  end

  def down
  end
end
