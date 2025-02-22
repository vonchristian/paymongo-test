class ParkingTicketsController < ApplicationController
  def index
    @parking_tickets = ParkingModule::ParkingTicket.order(entry_time: :desc)
    @parking_ticket = ParkingModule::ParkingService.new
  end

  def create
    @parking_ticket = ParkingModule::ParkingService.run(params[:parking_module_parking_service])

    if @parking_ticket.valid?
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to parking_tickets_path, notice: "Ticket created!" }
      end
    else
      puts @parking_ticket.errors.full_messages
      @parking_tickets = ParkingModule::ParkingTicket.order(entry_time: :desc)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("form_container", partial: "form", locals: { parking_ticket: @parking_ticket }), status: :unprocessable_entity }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  private

  def parking_ticket_params
    params.require(:parking_module_parking_ticket).permit(:plate_number, :entry_point)
  end
end
