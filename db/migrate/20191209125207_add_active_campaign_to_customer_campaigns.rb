class AddActiveCampaignToCustomerCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_campaigns, :active_campaign, :boolean
  end
end
