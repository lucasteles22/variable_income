class CreateEarnings < ActiveRecord::Migration[7.0]
  def change
    create_enum :kind, %w[dividend interest_on_equity income]

    create_table :earnings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :asset, null: false, foreign_key: true
      t.enum :kind, enum_type: 'kind', null: false
      t.date :paid_at, null: false
      t.integer :quantity, null: false
      t.decimal :unit_price, null: false, precision: 8, scale: 2
      t.decimal :net_value, null: false, precision: 8, scale: 2

      t.timestamps
    end

    add_index :earnings, %i[user_id asset_id paid_at kind], unique: true
    add_index :earnings, :kind
  end
end
