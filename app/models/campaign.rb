class Campaign < ApplicationRecord
  has_many :campaign_products, inverse_of: :campaign, :dependent => :destroy
  accepts_nested_attributes_for :campaign_products, reject_if: proc { |attributes| attributes['part_desc'].blank? }
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def self.expired_campaigns
    # If the campaign has expired mark all the customer campaign records as expired.
    all.each do |c|
      if !c.end_date < Time.current.strftime('%Y-%m-%d')
        customer_campaigns = CustomerCampaign.where(campaign_id: c.id)
        customer_campaigns.each do |cc|
          cc.campaign_expired = true
          cc.save
        end
      end
    end
  end

end
