class CreateProponents < ActiveRecord::Migration[8.0]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :document
      t.date :birthdate
      t.decimal :salary
      t.integer :inss_rate_type
      t.decimal :inss_rate

      t.timestamps
    end
  end
end
