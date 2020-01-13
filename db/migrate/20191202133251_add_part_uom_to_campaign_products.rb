class AddPartUomToCampaignProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :campaign_products, :part_uom, :string
  end
end
