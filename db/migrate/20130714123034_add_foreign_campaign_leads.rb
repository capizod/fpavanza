class AddForeignCampaignLeads < ActiveRecord::Migration
  def up
    # add a foreign key
    execute <<-SQL
      ALTER TABLE leads
        ADD CONSTRAINT fk_campaign_lead
        FOREIGN KEY (campaign_id)
        REFERENCES campaigns(id)
    SQL
  end

  def down
  end
end
