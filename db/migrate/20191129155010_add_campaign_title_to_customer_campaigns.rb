class AddCampaignTitleToCustomerCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_campaigns, :campaign_title, :string
  end
end
