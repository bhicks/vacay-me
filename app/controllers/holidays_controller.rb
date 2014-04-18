class HolidaysController < ApplicationController
  def index
    holidays = HolidayList.list.map {|h| HolidaySerializer.new h}
    # TODO: read from redis cache
    render json: holidays, status: :ok
  end
end
