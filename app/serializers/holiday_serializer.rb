class HolidaySerializer
  def initialize(holiday_json)
    @name = holiday_json[:summary]
    @date = holiday_json[:start_date].strftime('%m/%d/%Y')
  end
end
