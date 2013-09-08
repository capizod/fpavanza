class AddCProvider < ActiveRecord::Migration
  def up
     def change
      add_column :providers, :account_number, :string
     end
  end

  def down
  end
end
