class CreateProspects < ActiveRecord::Migration[5.1]
  def change
    create_table :prospects do |t|
      t.string :customer_id
      t.string :name
      t.string :credit_terms
      t.string :rep
      t.boolean :status
      t.string :source
      t.string :zip
      t.date :active_date
      t.boolean :customer
      t.string :city
      t.string :state
      t.string :ship_to
      t.boolean :compass
      t.boolean :new_opening

      t.timestamps
    end
  end
end
