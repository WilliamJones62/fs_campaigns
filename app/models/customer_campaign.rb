class CustomerCampaign < ApplicationRecord
  has_many :campaign_activities, inverse_of: :customer_campaign, :dependent => :destroy
  accepts_nested_attributes_for :campaign_activities, reject_if: proc { |attributes| attributes['activity'].blank? }
  validates_presence_of :custcode
  validates_presence_of :custname
end
