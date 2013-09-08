class AddForeignUserCampaign < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE campaigns
        ADD CONSTRAINT fk_campaign_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def down
  end
end
