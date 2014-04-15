class HolidayCache
  KEY ||= 'vacay_me::holidays'

  def clear(options = {})
    Redis.current.del HolidayCache::KEY
  end

  def store
    clear

    holidays.each do |holiday|
      Redis.current.zadd KEY, holiday[:start_date].to_time.to_i, holiday.to_json
    end
  end

  def retrieve(end_time = Time.now + 1.year)
    raise ArgumentError, 'end_time must be a Time' unless end_time.class == Time

    Redis.current.zrangebyscore(KEY, Time.now.to_i, end_time.to_i)
      .map {|h| JSON.parse(h).deep_symbolize_keys }
  end

  private

  def holidays
    HolidayList.list
  end
end
