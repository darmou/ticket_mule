require 'prawn/format'
#require 'prawn/layout'

Prawn.debug = true

#pdf.header pdf.margin_box.top_left do
#  pdf.font "Helvetica" do
#    pdf.text "This is the header", :size => 10, :align => :right
#    pdf.stroke_horizontal_rule
#  end
#end

#pdf.footer [pdf.margin_box.left, pdf.margin_box.bottom + 10] do
#  pdf.stroke_horizontal_rule
#  pdf.text "<br/>Ticket ##{@ticket.id} - TicketMule", :size => 9, :align => :right
#end

#pdf.repeat :all


#end



pdf.bounding_box([pdf.bounds.left, pdf.bounds.top],:width  => pdf.bounds.width, :height => pdf.bounds.height - 50) do

  pdf.text "Ticket ##{@ticket.id}", :size => 16, :style => :bold
  pdf.move_down(16)

  pdf.font_size(11) do
    pdf.text "Title: ", :style => :bold
    pdf.text "#{@ticket.title}"
    pdf.move_down(2)

    data = [["Contact: #{@ticket.contact.full_name}", @ticket.closed? ? "Closed at: #{nice_date @ticket.closed_at}" : ""],
            ["Created at: #{nice_date @ticket.created_at}", "Created by: #{@ticket.creator.username} (#{@ticket.creator.first_name} #{@ticket.creator.last_name})"],
            ["Priority: #{@ticket.priority.name}","Group: #{@ticket.group.name}"],
            ["Status: #{@ticket.status.name}","Owner: #{@ticket.owner.nil? ? 'Unassigned' : @ticket.owner.username}"],
			["Time Type:#{@ticket.time_type.name}",""],
			]

    pdf.table data
    pdf.move_down(5)
    pdf.text "Details:"
    pdf.text "#{@ticket.details}", :style => :bold
  end
end

#pdf.font_size(9) do
#  pdf.number_pages "Page <page> of <total>", [pdf.bounds.right - 50, 0]
#end
