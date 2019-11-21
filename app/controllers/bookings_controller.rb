class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    authorize @bookings
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.pet = Pet.find(params[:pet_id])
    @booking.status = "pending"
    authorize @booking

    if @booking.save
      redirect_to @booking.pet
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.update(booking_params)
      redirect_to booking_path

    else
      render 'edit'
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy

    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:endingdate, :status, :message, :startingdate, :user_id, :pet_id)
  end
end
