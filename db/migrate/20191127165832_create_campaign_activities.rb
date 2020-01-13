class CreateCampaignActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_activities do |t|
      t.integer :customer_campaign_id
      t.date :activity_date
      t.string :activity
      t.string :outcome

      t.timestamps
    end
  end
end
