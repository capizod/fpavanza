class AddForeignUserOpportunity < ActiveRecord::Migration
  def up    
    # add a foreign key
    execute <<-SQL
      ALTER TABLE opportunities
        ADD CONSTRAINT fk_opportunity_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def down
  end
end
