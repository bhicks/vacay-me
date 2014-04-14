class HolidayCache
  KEY ||= 'vacay_me::holidays'

  def clear_passed
    yesterday         = (Time.now - 1.day).to_i
    previous_holidays = Redis.current.zrangebyscore(KEY, 0, yesterday)

    previous_holidays.each do |previous_holiday|
      Redis.current.zrem KEY, previous_holiday
    end
  end

  def store
    clear_passed

    holidays.each do |holiday|
      Redis.current.zadd KEY, holiday[:start_date].to_time.to_i, holiday
    end
  end

  private

  def holidays
    HolidayList.list
  end
end
