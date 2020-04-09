class Ticket < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type

  after_destroy :update_after_destroy
  after_save :update_after_save

  private
    def update_after_destroy
      es = self.ticket_type.event.event_stat
      es.tickets_sold -= 1
      es.attendance -= 1
      es.save
    end

  def raise_exception
    raise 'An error has occurred, event attendance has surpassed the event capacity, no more tickets available'
  end

  private
    def update_after_save
      es = self.ticket_type.event.event_stat
      es.tickets_sold += 1
      es.attendance += 1
      es.save
      if es.tickets_sold > self.ticket_type.event.event_venue.capacity
        self.destroy
        raise_exception
      end
    end
end