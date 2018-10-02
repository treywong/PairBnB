class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
    	t.string :name
    	t.string :city
        t.string :state
        t.string :country
        t.string :zipcode
        t.string :address

    	t.decimal :price
    	t.string :detail
    	t.references :user, foreign_key: true

    	t.integer :guest_number
    	t.integer :bed_number
    	t.integer :room_number
    	t.integer :bath_number

    	t.timestamps
    end
  end
end
