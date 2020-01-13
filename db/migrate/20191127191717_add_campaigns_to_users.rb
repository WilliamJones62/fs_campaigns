class AddCampaignsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :campaigns, :boolean
  end
end
