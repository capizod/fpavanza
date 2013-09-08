class AddForeignUserLead < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE leads
        ADD CONSTRAINT fk_lead_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def down
  end
end
