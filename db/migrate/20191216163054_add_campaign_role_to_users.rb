class AddCampaignRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :campaign_role, :string
  end
end
