class CreateProviderTypes < ActiveRecord::Migration
  def change
    create_table :provider_types do |t|
      t.string :description, :limit => 255, :null => false
      t.string :internal_id, :limit => 18

      t.timestamps
    end
  end
end
