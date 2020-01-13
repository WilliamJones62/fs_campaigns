class AddUserNameToCustomerCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_campaigns, :user_name, :string
  end
end
