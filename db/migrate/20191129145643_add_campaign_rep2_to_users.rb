class AddCampaignRep2ToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :campaign_rep2, :string
  end
end
