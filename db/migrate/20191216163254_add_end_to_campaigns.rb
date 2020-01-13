class AddEndToCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :campaigns, :end_date, :date
  end
end
