class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, :limit => 255, :null => false
      t.string :internal_id, :limit => 18

      t.timestamps
    end
  end
end
