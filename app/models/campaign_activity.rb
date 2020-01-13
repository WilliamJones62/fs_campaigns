class CampaignActivity < ApplicationRecord
  belongs_to :customer_campaign, :foreign_key => "customer_campaign_id"
end
