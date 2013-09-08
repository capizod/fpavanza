class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :description, :limit => 255, :null => false
      t.timestamps
    end
  end
end
