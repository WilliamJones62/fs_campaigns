class CampaignProduct < ApplicationRecord
  belongs_to :campaign, :foreign_key => "campaign_id"
end
