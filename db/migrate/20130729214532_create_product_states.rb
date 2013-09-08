class CreateProductStates < ActiveRecord::Migration
  def change
    create_table :product_states do |t|
      t.string :description, :null => false
      t.string :alias, :null => false
      t.timestamps
    end
  end
end
