class AddCampaignExpiredToCustomerCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_campaigns, :campaign_expired, :boolean
  end
end
