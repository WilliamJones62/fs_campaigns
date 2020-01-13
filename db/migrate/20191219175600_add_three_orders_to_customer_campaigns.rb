class AddThreeOrdersToCustomerCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_campaigns, :three_orders, :boolean
  end
end
