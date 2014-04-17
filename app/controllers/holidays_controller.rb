class HolidaysController < ApplicationController
  def index
    # TODO: read from redis cache
    holidays = HolidayList.list
    holidays.map! do |holiday|
      holiday[:name] = holiday[:summary]
      holiday[:date] = holiday[:start_date].strftime("%m/%d/%Y")
      holiday
    end
    render json: holidays, status: :ok
  end
end
