class ItinerariesController < ApplicationController
  def index
    @trip = Trip.find(params[:trip_id])
    @itineraries = @trip.itineraries
    render :index, locals:{itineraries: @itineraries}
  end

  def show
    @trip = Trip.find(params[:trip_id])
    @itinerary = @trip.itineraries.find(params[:id])
    render :show, locals:{itinerary: @itinerary}
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @itinerary = Itinerary.new(trip: @trip)
    render :new, locals:{itinerary: @itinerary}
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @itinerary = @trip.itineraries.new(trip: @trip)
    @itinerary.assign_attributes(destination_params)
    if @itinerary.save!
      redirect_to trip_itinerary_path([@trip,@itinerary])
    else
      redirect_to new_trip_itinerary_path
    end
  end

  def edit
    @trip = Trip.find(params[:trip_id])
    @itinerary = @trip.itineraries.find(params[:id])
    render :edit, locals:{itinerary: @itinerary}
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @itinerary = @trip.itineraries.find(params[:id])
    @itinerary.assign_attributes(destination_params)
    if @itinerary.save
      redirect_to trip_itinerary_path([@trip,@itinerary])
    else
      redirect_to edit_trip_itinerary_path(@itinerary)
    end
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @itinerary = @trip.itineraries.find(params[:id])
    @itinerary.delete
    redirect_to trip_itineraries_path
  end

  private

  def destination_params
    params.require(:itinerary).permit(:location,:start_date, :end_date, :trip_id)
  end
end