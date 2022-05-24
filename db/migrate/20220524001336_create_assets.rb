class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.string :name

      t.timestamps
    end

    add_index :assets, :name, unique: true
  end
end
