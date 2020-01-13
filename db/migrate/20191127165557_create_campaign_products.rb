class CreateCampaignProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_products do |t|
      t.integer :campaign_id
      t.string :part_code
      t.string :part_desc

      t.timestamps
    end
  end
end
