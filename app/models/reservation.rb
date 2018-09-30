class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :date_start, presence: true
  validates :date_end, presence: true

  validate :check_dates
  validate :before_today
  validate :listing_overlap

  before_create :compute_total_price

  def check_dates
    if self.date_start > self.date_end
      errors.add(:date_error, "Start date must be before end date")
    end
  end

  def before_today
    today = Date.today
    if self.date_start <= today or self.date_end <= today
      errors.add(:date_error, "Reservation must be made after today")
    end
  end

  def listing_overlap
    list = Reservation.all.where(listing_id: self.listing_id).where.not(id: self.id)

    list.each do |l|
      if (self.date_start..self.date_end).overlaps?(l.date_start..l.date_end)
        errors.add(:Date, "Your reservation is overlaping with another! Pick another!")
        break
      end
    end
  end

  def compute_total_price
  	listing_price = Listing.find(self.listing_id).price

  	self.total_price = (self.date_end - self.date_start) * listing_price
  	
  end
end