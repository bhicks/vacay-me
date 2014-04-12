class UpcomingHolidaysController < ApplicationController
  def index
    holidays = HolidayList.list
    render json: holidays, status: :ok
  end
end
