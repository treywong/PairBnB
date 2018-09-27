class AddGuestAndPriceToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :guest, :integer
    add_column :reservations, :total_price, :integer
  end
end
