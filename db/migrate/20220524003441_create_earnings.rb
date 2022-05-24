class CreateEarnings < ActiveRecord::Migration[7.0]
  def change
    create_enum :kind, ["dividend", "interest_on_equity", "income"]

    create_table :earnings do |t|
      t.references :asset, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.enum :kind, enum_type: "kind", null: false
      t.date :paid_at, null: false
      t.integer :quantity, null: false
      t.decimal :unit_price, null: false, precision: 8, scale: 2
      t.decimal :net_value, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
