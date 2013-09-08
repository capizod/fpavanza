class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :product_type, :null => false
      t.string     :account_number
      t.date       :starts_on
      t.date       :ends_on
      t.timestamps
    end
  end
end
