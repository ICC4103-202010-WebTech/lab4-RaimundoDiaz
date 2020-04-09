class EventVenue < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :capacity, numericality: { only_integer:  true, greater_than_or_equal_to: 10 }
  has_many :events
end
