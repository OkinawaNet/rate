class CreateDollarRates < ActiveRecord::Migration[5.1]
  def change
    create_table :dollar_rates do |t|
      t.integer :value
      t.integer :forced_value
      t.timestamp :forced_until

      t.timestamps
    end
  end
end
