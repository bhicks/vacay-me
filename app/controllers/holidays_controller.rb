class HolidaysController < ApplicationController
  def index
    # TODO: read from redis cache
    render json: holidays, status: :ok
  end

  private

  def holidays
    HolidayList.list.map {|h| Holiday.new h}
  end


  class Holiday
    def initialize(holiday_json)
      @name = holiday_json[:summary]
      @date = holiday_json[:start_date].strftime("%m/%d/%Y")
    end
  end
end
