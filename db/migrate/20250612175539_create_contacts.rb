class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.references :proponent, null: false, foreign_key: true
      t.integer :contact_type
      t.string :value

      t.timestamps
    end
  end
end
