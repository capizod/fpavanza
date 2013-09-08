class ProductPackage < ActiveRecord::Migration
  def change
    create_table :product_packages do |t|
      t.string :description, :limit => 255, :null => false
      t.references :product_type, :null => false

      t.timestamps
    end
  end
end
