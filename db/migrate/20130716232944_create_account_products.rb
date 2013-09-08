class CreateAccountProducts < ActiveRecord::Migration
  def change
    create_table :account_products do |t|
      t.references :product, :null => false
      t.references :account, :null => false
      t.timestamps
    end
  end
end
