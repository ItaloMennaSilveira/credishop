class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :proponent, null: false, foreign_key: true
      t.string :street
      t.string :number
      t.string :complement
      t.string :district
      t.string :zip_code
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
