HolidayList.configure do |config|
  config.id  = 'usa__en@holiday.calendar.google.com'
  config.key = ENV.fetch('GOOGLE_ACCESS_KEY', 'A_GOOD_KEY')
end
