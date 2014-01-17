require 'httparty'
require 'json'

class HolidayEnumerator
  include Enumerable

  def each
    calendar_items.map do |item|
      yield item
    end
  end

  private

  def calendar_items
    fail ArgumentError,'A valid google access key is required' if invalid_request?
    json_response['items'].map do |item|
      {
        summary:    item['summary'],
        start_date: item['start']['date'],
        etag:       item['etag']
      }
    end
  end

  def invalid_request?
    return false unless response_error
    response_error['code'] == 400
  end

  def response
    HTTParty.get GoogleCalendarRequestString.new
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  def response_error
    json_response['error']
  end

  class GoogleCalendarRequestString
    attr_reader :id, :params

    def initialize
      @id     = 'usa__en@holiday.calendar.google.com'
      @params = Params.new(google_access_key)
    end

    def to_str
      "https://www.googleapis.com/calendar/v3/calendars/#{id}/events?#{params}"
    end

    private

    def google_access_key
      ENV.fetch('GOOGLE_ACCESS_KEY') do
        fail ArgumentError, 'A valid google access key is required'
      end
    end

    class Params
      attr_reader :key, :time_min, :time_max

      def initialize(key, time_options = {})
        @key      = key
        @time_min = time_options.fetch('start') { DateTime.now.to_s }
        @time_max = time_options.fetch('end') { (DateTime.now + 1.year).to_s }
      end

      def to_s
        {
          key:          key,
          orderBy:      'startTime',
          singleEvents: true,
          timeMin:      time_min,
          timeMax:      time_max
        }.to_param
      end
    end
  end
end
