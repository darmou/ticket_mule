class DashboardController < ApplicationController
  before_filter :require_user
  before_filter :set_current_tab

  def index
    #todo lets put our wufoo grabbing stuff hree
    #see which is the lastest date of tickets and then grab any tickets since the latest or if no tickets
    #grab everything and put it into our system as open tickets
    puts "test are we here yet"
    lastTicket = Ticket.find(:last)
    if not lastTicket.nil?
      last_date = lastTicket.created_at.to_s
      puts last_date
    end 
    
    @active_tickets = Ticket.not_closed.active_tickets
    @closed_tickets = Ticket.closed_tickets

    # create array of date strings from 30 days ago up to yesterday
    @timeline = ((Time.zone.now - 30.days).to_date..(Time.zone.now - 1.day).to_date).inject([]){ |accum, date| accum << date.to_s }

    @timeline_opened_tickets = Ticket.timeline_opened_tickets
    @timeline_closed_tickets = Ticket.timeline_closed_tickets

    @max_opened = 0
    @max_closed = 0

    @timeline_opened_tickets.each_value do |v|
      @max_opened = v unless v <= @max_opened
    end

    @timeline_closed_tickets.each_value do |v|
      @max_closed = v unless v <= @max_closed
    end
  end

  private

  def set_current_tab
    @current_tab = :dashboard
  end

end
