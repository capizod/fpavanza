class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name, :null => false
      t.references :provider_type, :null => false
      t.string :internal_key, :limit => 10
      
      t.timestamps
    end
  end
end
