class AddCampaignsAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :campaigns_admin, :boolean
  end
end
