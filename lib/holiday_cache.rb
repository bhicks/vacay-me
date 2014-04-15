class HolidayCache
  KEY ||= 'vacay_me::holidays'

  def clear_passed
    yesterday = (Time.now - 1.day).to_i
    Redis.current.zremrangebyscore(KEY, 0, yesterday)
  end

  def store
    clear_passed

    holidays.each do |holiday|
      Redis.current.zadd KEY, holiday[:start_date].to_time.to_i, holiday
    end
  end

  def retrieve(end_time = Time.now + 1.year)
    raise ArgumentError, 'end_time must be a Time' unless end_time.class == Time

    Redis.current.zrangebyscore(KEY, Time.now.to_i, end_time.to_i)
  end

  private

  def holidays
    HolidayList.list
  end
end
