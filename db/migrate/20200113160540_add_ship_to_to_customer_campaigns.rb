class AddShipToToCustomerCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_campaigns, :ship_to, :string
  end
end
