class TicketDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def place_were_opened
    "Ticket opened for #{unit.name}"
  end

  def created_by
    "Created by #{user.full_name}"
  end
end