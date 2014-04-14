class HolidayCache
  def store
    holidays.each do |holiday|
      Redis.current.zadd 'vacay_me::holidays', holiday[:start_date].to_time.to_i, holiday
    end
  end

  private

  def holidays
    HolidayList.list
  end
end
