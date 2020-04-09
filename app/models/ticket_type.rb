class TicketType < ApplicationRecord
  validates :ticket_price, numericality: { greater_than_or_equal_to: 0}
  belongs_to :event
end
