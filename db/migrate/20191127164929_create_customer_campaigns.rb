class CreateCustomerCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_campaigns do |t|
      t.string :custcode
      t.string :custname
      t.integer :campaign_id

      t.timestamps
    end
  end
end
