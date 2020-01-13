class AddCampaignRep1ToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :campaign_rep1, :string
  end
end
