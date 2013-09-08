class AddForeignCampaignOpp < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE opportunities
        ADD CONSTRAINT fk_campaign_opp
        FOREIGN KEY (campaign_id)
        REFERENCES campaigns(id)
    SQL
  end

  def down
  end
end
