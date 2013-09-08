class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :description, :limit => 255, :null => false
      t.string :alias, :limit => 18, :null => false

      t.timestamps
    end
  end
end
